**Yes! Connect-RPC is specifically designed to solve this problem.** It supports Flutter Web/WASM out of the box.

## Why Connect-RPC Works for WASM

Connect-RPC uses standard HTTP/1.1 or HTTP/2 (when available) with JSON or binary formats, making it compatible with browsers. It's essentially "gRPC for the web" without needing a proxy.

## Key Advantages

1. **Browser Compatible** - Uses `fetch` API under the hood
2. **Same Proto Files** - Use your existing gRPC `.proto` definitions
3. **Multiple Protocols** - Supports gRPC, gRPC-Web, and Connect protocol
4. **No Proxy Required** - Unlike grpc-web which needs Envoy
5. **Streaming Support** - Server streaming works in browsers

## Setup for Flutter WASM

**1. Add Dependencies**

```yaml
dependencies:
  connectrpc: ^0.1.0
  http: ^1.0.0

dev_dependencies:
  protoc_plugin: ^21.0.0
```

**2. Generate Code (same proto as before)**

```bash
# Install protoc-gen-connect-dart
dart pub global activate protoc_plugin

# Generate
protoc --dart_out=grpc:lib/generated \
       --connect-dart_out=lib/generated \
       -Iprotos protos/events.proto
```

**3. Create Connect Client for Streaming Events**

```dart
import 'package:connectrpc/connectrpc.dart';
import 'generated/events.connect.client.dart';
import 'generated/events.pb.dart';

class ConnectEventManager {
  late final EventServiceClient _client;
  final _eventController = StreamController<Event>.broadcast();
  
  Stream<Event> get eventStream => _eventController.stream;
  
  ConnectEventManager(String baseUrl) {
    final transport = Transport(
      baseUrl: baseUrl,
      codec: Codec.jsonCodec, // or Codec.protoCodec for binary
      httpClient: HttpClient(), // Uses dart:html fetch on web
    );
    
    _client = EventServiceClient(transport);
  }
  
  // Server streaming works!
  Future<void> subscribeToEvents(String userId) async {
    try {
      final request = SubscribeRequest()..userId = userId;
      
      // This creates a server stream that works in browsers
      final stream = _client.subscribeToEvents(request);
      
      await for (final event in stream) {
        print('Received event: ${event.eventType}');
        _eventController.add(event);
      }
    } catch (e) {
      print('Stream error: $e');
      _eventController.addError(e);
    }
  }
  
  void dispose() {
    _eventController.close();
  }
}
```

**4. Use in Flutter (works on mobile AND web)**

```dart
class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late ConnectEventManager _eventManager;
  final List<Event> _events = [];
  
  @override
  void initState() {
    super.initState();
    _initializeEvents();
  }
  
  void _initializeEvents() async {
    _eventManager = ConnectEventManager('https://your-server.com');
    
    // Listen to events
    _eventManager.eventStream.listen((event) {
      setState(() {
        _events.insert(0, event);
      });
      
      if (event.eventType == 'alarm') {
        _showAlarm(event);
      }
    });
    
    // Start streaming
    _eventManager.subscribeToEvents('user123');
  }
  
  void _showAlarm(Event event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🔔 ${event.message}')),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events (Connect-RPC)')),
      body: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_events[index].eventType),
            subtitle: Text(_events[index].message),
          );
        },
      ),
    );
  }
  
  @override
  void dispose() {
    _eventManager.dispose();
    super.dispose();
  }
}
```

## Server-Side Compatibility

Your Connect-RPC server can handle:
- Standard gRPC clients (mobile apps)
- Connect clients (web/WASM)
- gRPC-Web clients

All using the same proto definitions and server implementation!

## Comparison Updated

| Feature | SSE | WebSocket | gRPC | **Connect-RPC** |
|---------|-----|-----------|------|-----------------|
| WASM Support | ✅ | ✅ | ❌ | ✅ |
| Server Streaming | ✅ | ✅ | ❌ | ✅ |
| Bidirectional | ❌ | ✅ | ❌ | ⚠️ Limited* |
| Proto Support | ❌ | ❌ | ✅ | ✅ |
| Mobile + Web | ✅ | ✅ | Mobile only | ✅ |
| Same Code | ❌ | ❌ | ❌ | ✅ |

*Connect supports unary and server streaming well; client/bidirectional streaming has browser limitations

## Verdict

**Yes, use Connect-RPC if:**
- You want one codebase for mobile AND web
- You like gRPC's proto-based approach
- You need server streaming for events
- You want type safety and code generation

It's the best of both worlds - gRPC developer experience with web compatibility.