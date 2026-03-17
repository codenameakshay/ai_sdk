# flutter_chat

Flutter example app for [AI SDK Dart](https://pub.dev/packages/ai) — demonstrates all three `ai_sdk_flutter` controllers with a polished Material 3 UI.

## Screens

| Screen | Controller | What it shows |
|--------|-----------|---------------|
| **Chat** | `ChatController` | Multi-turn streaming chat with optimistic bubbles, stop button, clear history |
| **Completion** | `CompletionController` | Single-turn text generation with preset chips and live streaming output |
| **Object** | `ObjectStreamController` | Streams a typed JSON object (country profile) — fields appear as they arrive |

## Run

The API key is injected at build/run time via `--dart-define` (works on all platforms — Android, iOS, web, desktop):

```sh
# From repo root
fvm flutter run --dart-define=OPENAI_API_KEY=sk-...

# Web
fvm flutter run -d chrome --dart-define=OPENAI_API_KEY=sk-...

# Release build
fvm flutter build apk --dart-define=OPENAI_API_KEY=sk-...
```

## Structure

```
lib/
  main.dart                  # App shell + bottom NavigationBar
  config.dart                # API key from environment
  pages/
    chat_page.dart           # ChatController demo
    completion_page.dart     # CompletionController demo
    object_stream_page.dart  # ObjectStreamController demo
```

## Key patterns

### ChatController

```dart
final agent = ToolLoopAgent(
  model: OpenAIProvider(apiKey: apiKey)('gpt-4.1-mini'),
  instructions: 'You are a helpful assistant.',
  maxSteps: 5,
);

final chat = ChatController(
  onFinish: (msg) => print('Done: ${msg.content}'),
);

// Send a message and stream the reply
await chat.sendMessage(agent: agent, text: 'Hello!');

// In the widget tree, rebuild on change:
ListenableBuilder(
  listenable: chat,
  builder: (context, _) {
    return Text(chat.streamingContent); // live streaming text
  },
);
```

### CompletionController

```dart
final completion = CompletionController(
  agent: ToolLoopAgent(model: OpenAIProvider(apiKey: apiKey)('gpt-4.1-mini')),
);

await completion.complete('Explain async/await in Dart.');
print(completion.completion); // streamed result
```

### ObjectStreamController

```dart
final controller = ObjectStreamController<Map<String, dynamic>>(
  onFinish: (value) => print('Final: $value'),
);

final stream = await streamText<Map<String, dynamic>>(
  model: OpenAIProvider(apiKey: apiKey)('gpt-4.1-mini'),
  prompt: 'Country profile for Japan.',
  output: Output.object(schema: mySchema),
);

await controller.bind(
  stream.partialOutputStream.map((v) => v as Map<String, dynamic>),
);
```
