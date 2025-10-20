## ``ProductInfo`` Service and Client - Go Implementation

## Building and Running Service

In order to build, Go to ``Go`` module root directory location (productinfo/go/server) and execute the following
 shell command,
```
go build -v -o bin/server
```

In order to run, Go to ``Go`` module root directory location (productinfo/go/server) and execute the following
shell command,

```
./bin/server
```

## Building and Running Client   

In order to build, Go to ``Go`` module root directory location (productinfo/go/client) and execute the following
 shell command,
```
go build -v -o bin/client
```

In order to run, Go to ``Go`` module root directory location (productinfo/go/client) and execute the following
shell command,

```
./bin/client
```

## Additional Information

### Make sure protobuf and proto-gen-go-grpc are installed

Install protobuf: `brew install protobuf`

Install `proto-gen-go-grpc`:
```
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

### Generate Server and Client side code
Modified `.proto` to include new `go_module`, e.g.: `option go_package = "server/ecommerce";`
```
protoc -I proto/ proto/product_info.proto --go_out=. --go-grpc_out=.
```

