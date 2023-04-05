
# Working with protoc

Updating command to generate protoc

```
protoc --proto_path=proto --go_opt=Mproduct_info.proto=./ecommerce --go_out=server/ --go-grpc_opt=Mproduct_info.proto=./ecommerce --go-grpc_opt=require_unimplemented_servers=false --go-grpc_out=server/ product_info.proto

protoc --proto_path=proto --go_opt=Mproduct_info.proto=./ecommerce --go_out=client/ --go-grpc_opt=Mproduct_info.proto=./ecommerce --go-grpc_opt=require_unimplemented_servers=false --go-grpc_out=client/ product_info.proto
```

This creates two new proto files
``
../client/ecommerce/product_info.pb.go
../client/ecommerce/product_info_grpc.pb.go
../server/ecommerce/product_info.pb.go
../server/ecommerce/product_info_grpc.pb.go
```

Reasons for changes, with latest versions of protocol buffers tools
```
protoc-gen-go v1.30.0
protoc        v3.21.12
```

## Additional workarounds

Fixes this issue when trying to build
```
[12:36:38:rojasfe@bianca-gurru:../grpc/productinfo/server]$ go build main.go
# command-line-arguments
./main.go:61:34: cannot use &server{} (value of type *server) as type ecommerce.ProductInfoServer in argument to pb.RegisterProductInfoServer:
	*server does not implement ecommerce.ProductInfoServer (missing mustEmbedUnimplementedProductInfoServer method)
```
[grpc-issue-3794](https://github.com/grpc/grpc-go/issues/3794)
  - unimplemented server bypass, there's an unimplemented method (learn more later)

[protobuf-issue-1070](https://github.com/golang/protobuf/issues/1070)
  - The "gRPC Up and Running" uses old syntax which uses plugins which are no longer supported, you have to use protoc-gen-go instead by specifying `--go-grpc_out`

## Book syntax updating
```
protoc --proto_path=proto --go_opt=Mproduct_info.proto=./ecommerce --go_out=server/ --go-grpc_opt=Mproduct_info.proto=./ecommerce --go-grpc_opt=require_unimplemented_servers=false --go-grpc_out=go/server/ product_info.proto

protoc --proto_path=proto --go_opt=Mproduct_info.proto=./ecommerce --go_out=client/ --go-grpc_opt=Mproduct_info.proto=./ecommerce --go-grpc_opt=require_unimplemented_servers=false --go-grpc_out=go/client/ product_info.proto
```

