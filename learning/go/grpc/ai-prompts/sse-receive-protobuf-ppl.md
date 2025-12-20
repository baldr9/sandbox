# Can you send a protobuf using server sent events

Yes, you can send protobuf messages using Server-Sent Events (SSE) from a backend to a Flutter client, but it requires encoding the binary protobuf data as base64 strings in the SSE `data` field since SSE expects UTF-8 text payloads.[^1][^2]

## Server-Side Implementation

On the backend (e.g., Go, Node.js, or Dart server), set the SSE headers and stream events:

- `Content-Type: text/event-stream`
- `Cache-Control: no-cache`
- `Connection: keep-alive`

Encode each protobuf message to base64 and send as `data:` lines terminated by `\n\n`. Example conceptual server snippet (pseudocode):

```
event: update
data: <base64-encoded-protobuf-bytes>

event: update
data: <next-base64-protobuf>
```

This keeps the stream compliant while transporting binary data.[^2][^3][^1]

## Flutter Client Implementation

Use Dart's `StreamController` or `http` with manual SSE parsing, or the `sse_client` package for SSE support. Decode base64 back to bytes, then parse with your generated protobuf classes.

Add to `pubspec.yaml`:

```
dependencies:
  sse_client: ^0.2.1  # or latest
  protobuf: ^3.1.0
```

Example client code:

```dart
import 'package:sse_client/sse_client.dart';
import 'package:protobuf/protobuf.dart';  // Your generated MyMessage.pb.dart

final sse = SseClient('https://api.example.com/events');

sse.stream.listen((event) {
  if (event.event == 'update') {
    final bytes = base64Decode(event.data!);
    final msg = MyMessage.fromBuffer(bytes);  // Generated protobuf class
    // Handle msg (e.g., update UI)
  }
});
```

The client automatically handles reconnection via `lastEventId`.[^2]

## Considerations

- Base64 adds ~33% overhead but ensures binary safety over text streams.[^1]
- Protobuf over SSE works well for unary or streaming responses without gRPC's overhead, ideal for fire-and-forget updates.
- Test UTF-8 compliance; avoid raw binary bytes directly in `data` to prevent stream corruption.[^3][^2]

This pairs naturally with your prior gRPC/protobuf setup in Flutter for hybrid streaming needs.
<span style="display:none">[^10][^4][^5][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://github.com/andywer/http-event-stream

[^2]: https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events

[^3]: https://jvns.ca/blog/2021/01/12/day-36--server-sent-events-are-cool--and-a-fun-bug/

[^4]: https://www.speakeasy.com/openapi/content/server-sent-events

[^5]: https://www.reddit.com/r/dotnet/comments/1fba0th/how_to_implement_serversent_events/

[^6]: https://pekko.apache.org/docs/pekko-http/1.0/common/sse-support.html

[^7]: https://news.ycombinator.com/item?id=42511318

[^8]: https://www.reddit.com/r/node/comments/1gdzt9p/i_made_a_library_that_makes_it_a_breeze_to_use/

[^9]: https://stackoverflow.com/questions/13278365/downside-of-using-server-sent-events-for-bidirectional-client-server-communicati

[^10]: https://stackoverflow.com/questions/20572193/how-are-server-sent-events-implemented/20884360

