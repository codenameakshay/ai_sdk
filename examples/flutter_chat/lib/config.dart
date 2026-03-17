/// OpenAI API key injected at build time via --dart-define.
///
/// Pass the key when running or building:
///
///   fvm flutter run --dart-define=OPENAI_API_KEY=sk-...
///   fvm flutter build apk --dart-define=OPENAI_API_KEY=sk-...
///
/// For production apps, consider flutter_dotenv or flutter_secure_storage
/// to avoid baking the key into the binary.
const String openAiApiKey = String.fromEnvironment('OPENAI_API_KEY');
