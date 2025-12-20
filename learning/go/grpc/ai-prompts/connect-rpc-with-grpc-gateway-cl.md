# Using Connect-RPC with gRPC Gateway

## Architecture Overview

```
┌─────────────┐
│ Flutter App │
│  (Mobile)   │──────gRPC─────┐
└─────────────┘               │
                              ▼
┌─────────────┐         ┌──────────┐
│ Flutter Web │         │  gRPC    │
│   (WASM)    │─Connect─▶  Server  │
└─────────────┘         │   (Go)   │
                        └──────────┘
                              │
                        ┌─────▼──────┐
                        │ grpc-gateway│
                        │  (optional) │
                        └─────┬──────┘
                              │
                        ┌─────▼──────┐
                        │  REST API  │
                        │  (legacy)  │
                        └────────────┘
```

## The Key Insight

**Connect-RPC and grpc-gateway both use the same `.proto` files!**

- Your gRPC server remains unchanged
- Connect-RPC clients can talk directly to your gRPC server (if it supports HTTP/2)
- grpc-gateway provides REST/JSON endpoints for legacy systems
- All three use identical proto definitions

## Implementation

**1. Single Proto Definition**

```protobuf
syntax = "proto3";

package events.v1;

import "google/api/annotations.proto"; // For grpc-gateway

service EventService {
  // Server streaming for events
  rpc SubscribeToEvents(SubscribeRequest) returns (stream Event) {
    option (google.api.http) = {
      get: "/v1/events/subscribe"
    };
  }
  
  // Unary call example
  rpc AcknowledgeEvent(AckRequest) returns (AckResponse) {
    option (google.api.http) = {
      post: "/v1/events/{event_id}/ack"
      body: "*"
    };
  }
}

message SubscribeRequest {
  string user_id = 1;
}

message Event {
  string event_id = 1;
  string event_type = 2;
  string message = 3;
  int64 timestamp = 4;
}

message AckRequest {
  string event_id = 1;
}

message AckResponse {
  bool success = 1;
}
```

**2. Go Server with Both gRPC and Connect Support**

```go
package main

import (
    "context"
    "log"
    "net/http"
    
    "connectrpc.com/connect"
    "connectrpc.com/grpchealth"
    "connectrpc.com/grpcreflect"
    "golang.org/x/net/http2"
    "golang.org/x/net/http2/h2c"
    "google.golang.org/grpc"
    
    eventsv1 "yourapp/gen/events/v1"
    "yourapp/gen/events/v1/eventsv1connect"
)

type EventServer struct {
    eventsv1.UnimplementedEventServiceServer
}

func (s *EventServer) SubscribeToEvents(
    req *eventsv1.SubscribeRequest, 
    stream eventsv1.EventService_SubscribeToEventsServer,
) error {
    // Your streaming logic here
    for {
        event := &eventsv1.Event{
            EventId: "123",
            EventType: "alarm",
            Message: "Wake up!",
        }
        
        if err := stream.Send(event); err != nil {
            return err
        }
        
        time.Sleep(5 * time.Second)
    }
}

func (s *EventServer) AcknowledgeEvent(
    ctx context.Context, 
    req *eventsv1.AckRequest,
) (*eventsv1.AckResponse, error) {
    return &eventsv1.AckResponse{Success: true}, nil
}

func main() {
    server := &EventServer{}
    
    // Create Connect handler (works for web/WASM)
    mux := http.NewServeMux()
    path, handler := eventsv1connect.NewEventServiceHandler(server)
    mux.Handle(path, handler)
    
    // Add CORS for web clients
    handler = cors.AllowAll().Handler(mux)
    
    // Serve both gRPC and Connect on same port using h2c
    log.Println("Server listening on :8080")
    http.ListenAndServe(
        ":8080",
        h2c.NewHandler(handler, &http2.Server{}),
    )
}
```

**3. Or Use Separate Ports (Simpler)**

```go
func main() {
    server := &EventServer{}
    
    // gRPC server (for mobile)
    go func() {
        lis, _ := net.Listen("tcp", ":50051")
        grpcServer := grpc.NewServer()
        eventsv1.RegisterEventServiceServer(grpcServer, server)
        log.Println("gRPC server on :50051")
        grpcServer.Serve(lis)
    }()
    
    // Connect server (for web/WASM)
    mux := http.NewServeMux()
    path, handler := eventsv1connect.NewEventServiceHandler(server)
    mux.Handle(path, handler)
    
    log.Println("Connect server on :8080")
    http.ListenAndServe(":8080", mux)
}
```

**4. Flutter Client - Same Code, Different Transports**

```dart
import 'package:flutter/foundation.dart' show kIsWeb;

class EventManager {
  late final dynamic _client;
  
  EventManager() {
    if (kIsWeb) {
      // Use Connect-RPC for web/WASM
      final transport = Transport(
        baseUrl: 'https://your-server.com:8080',
        codec: Codec.protoCodec,
      );
      _client = EventServiceClient(transport);
    } else {
      // Use native gRPC for mobile
      final channel = ClientChannel(
        'your-server.com',
        port: 50051,
        options: ChannelOptions(
          credentials: ChannelCredentials.secure(),
        ),
      );
      _client = EventServiceClient(channel);
    }
  }
  
  Stream<Event> subscribeToEvents(String userId) {
    final request = SubscribeRequest()..userId = userId;
    return _client.subscribeToEvents(request);
  }
  
  Future<AckResponse> acknowledgeEvent(String eventId) {
    final request = AckRequest()..eventId = eventId;
    return _client.acknowledgeEvent(request);
  }
}
```

## Adding grpc-gateway (Optional)

If you also need REST endpoints:

```go
import (
    "github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
    eventsv1 "yourapp/gen/events/v1"
)

func main() {
    // ... existing gRPC server ...
    
    // Add grpc-gateway for REST
    go func() {
        mux := runtime.NewServeMux()
        opts := []grpc.DialOption{grpc.WithInsecure()}
        
        eventsv1.RegisterEventServiceHandlerFromEndpoint(
            context.Background(),
            mux,
            "localhost:50051",
            opts,
        )
        
        log.Println("REST gateway on :8081")
        http.ListenAndServe(":8081", mux)
    }()
    
    select {} // Keep running
}
```

Now you have:
- **Port 50051**: Native gRPC (mobile apps)
- **Port 8080**: Connect-RPC (web/WASM)
- **Port 8081**: REST/JSON (legacy systems, curl testing)

All from **one proto file** and **one server implementation**!

## Benefits of This Approach

✅ **Single source of truth** - One `.proto` file
✅ **Code reuse** - Same server logic for all clients
✅ **Type safety** - Generated code for all platforms
✅ **Flexibility** - Support mobile, web, and REST simultaneously
✅ **Performance** - Native gRPC for mobile, Connect for web
✅ **Testing** - Use REST endpoints with curl for debugging

This is exactly the kind of architecture Connect-RPC and grpc-gateway were designed for!