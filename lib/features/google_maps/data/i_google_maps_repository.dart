abstract class IGoogleMapsRepository {
  Future<void> addGoogleMapsDependency(String projectPath);
  Future<void> configureAndroid(String projectPath, String apiKey);
  Future<void> configureIOS(String projectPath, String apiKey);
  bool isAndroidManifestContainsKey(String projectPath);
  bool isIOSApiKeyAlreadyAdded(String content);
}
