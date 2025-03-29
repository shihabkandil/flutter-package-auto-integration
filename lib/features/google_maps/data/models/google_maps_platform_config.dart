import '../../cubits/google_maps_integration_cubit/google_maps_integration_cubit.dart';

class GoogleMapsPlatformConfig {
  GoogleMapsPlatformConfig({
    required this.apiKey,
    required this.platform,
    required this.path,
  });

  final String apiKey;
  final PlatformConfig platform;
  final String path;
}
