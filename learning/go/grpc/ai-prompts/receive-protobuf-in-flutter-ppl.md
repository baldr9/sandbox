# In Flutter how can you receive a protobuf from a backend service

You receive a protobuf in Flutter by generating Dart classes from your `.proto` files, then deserializing the binary response (from HTTP or gRPC) into those classes using the protobuf APIs.[^1][^2]

## Setup in Flutter

1. Add dependencies in `pubspec.yaml` (typical):
    - `protobuf` for message classes
    - `grpc` for gRPC, if you use it.[^2][^1]
2. Run `protoc` with the Dart plugin to generate Dart code from your `.proto` definitions, for example:
    - `protoc --dart_out=grpc:lib/src/generated -Iprotos protos/*.proto`.[^3][^2]
3. Import the generated `*.pb.dart` (and `*.pbgrpc.dart` for gRPC) files in your Flutter code.[^4][^3]

## Receiving protobuf over HTTP

If the backend exposes plain HTTP/REST but responds with a protobuf body:

- Make the request with `http` and expect binary bytes.
- Use the generated `fromBuffer`/`mergeFromBuffer` to decode `response.bodyBytes`.[^5][^1]

Example pattern:

```dart
final response = await http.get(
  Uri.parse('https://api.example.com/subscribers/$id'),
  headers: {'Accept': 'application/x-protobuf'},
);

if (response.statusCode == 200) {
  final msg = MyMessage.fromBuffer(response.bodyBytes);
  // use msg
}
```

The backend should set `Content-Type: application/x-protobuf` or `application/protobuf` on the response so the client knows it is protobuf, but on the Dart side you only really care that you treat it as raw bytes.[^6][^5][^1]

## Receiving protobuf via gRPC

If your backend is gRPC, you typically:

1. Generate client stubs with `--dart_out=grpc:...`.[^3][^2]
2. Create a `ClientChannel` in Flutter pointing to your service (with TLS or plaintext as appropriate).
3. Instantiate the generated client and call methods, which return decoded protobuf objects directly.[^7][^2]

Conceptual pattern:

```dart
final channel = ClientChannel(
  'api.example.com',
  port: 443,
  options: const ChannelOptions(credentials: ChannelCredentials.secure()),
);

final client = MyServiceClient(channel);

final request = MyRequest()..id = '123';
final response = await client.getSomething(request);

// response is already a MyResponse protobuf instance
```

The gRPC library handles framing and binary protobuf encoding/decoding for you, so on the Flutter side you just work with generated Dart classes.[^8][^2][^3]

## Notes and pitfalls

- Ensure the client and server use the same `.proto` definitions and versions; mismatches in field numbers/types will cause decode issues.[^9][^1]
- When using HTTP, always decode `response.bodyBytes`, not `response.body`, because protobuf is binary, not UTF‑8 text.[^5][^1]
- Consider mapping protobuf DTOs to separate app-domain models so the protobuf layer stays at the boundary of your Flutter app.[^2][^4]

If you share whether your backend is gRPC, REST+protobuf, or something else, a more concrete, idiomatic snippet for your setup can be sketched.
<span style="display:none">[^10]</span>

<div align="center">⁂</div>

[^1]: https://jsontotable.org/blog/protobuf/dart-protobuf-guide

[^2]: https://vibe-studio.ai/insights/building-flutter-apps-with-grpc-and-protobuf

[^3]: https://grpc-dart-docs.pages.dev/docs/grpc-basics/your-first-grpc-server-in-dart/

[^4]: https://www.inqvine.com/blog/flutter-tips-5

[^5]: https://ssojet.com/serialize-and-deserialize/serialize-and-deserialize-protobuf-in-flutter-web/

[^6]: https://mojoauth.com/serialize-and-deserialize/serialize-and-deserialize-protobuf-with-flutter-web/

[^7]: https://www.technicalfeeder.com/2023/07/dart-the-first-grpc-server-and-client-with-timestamp/

[^8]: https://stackoverflow.com/questions/77903756/dart-protoc-compilation-does-not-create-grpc-client-class

[^9]: https://stackoverflow.com/questions/13937882/parsing-protocol-buffers-without-knowing-the-proto

[^10]: https://www.reddit.com/r/FlutterDev/comments/1nfc8k5/can_anybody_share_opinion_about_protobufsome/

