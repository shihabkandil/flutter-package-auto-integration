import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../../data/i_google_maps_repository.dart';
import '../../data/models/google_maps_platform_config.dart';

part 'google_maps_integration_state.dart';

enum PlatformConfig { iOS, android }

class GoogleMapsIntegrationCubit extends Cubit<GoogleMapsIntegrationState> {
  GoogleMapsIntegrationCubit({IGoogleMapsRepository? repository})
    : _repository = repository ?? getIt<IGoogleMapsRepository>(),
      super(GoogleMapsInitial());

  final IGoogleMapsRepository _repository;

  Future<void> integrate(String projectPath) async {
    emit(GoogleMapsLoading());

    await _repository.addGoogleMapsDependency(projectPath);
    emit(GoogleMapsDependencyAdded());

    if (!_repository.isAndroidManifestContainsKey(projectPath)) {
      emit(GoogleMapsKeyNeeded(PlatformConfig.android));
    }
    emit(GoogleMapsLoading());
    if (!_repository.isIOSApiKeyAlreadyAdded(projectPath)) {
      emit(GoogleMapsKeyNeeded(PlatformConfig.iOS));
    }
  }

  Future<void> continueIntegrationWithPlatformApiKey(
    GoogleMapsPlatformConfig config,
  ) async {
    emit(GoogleMapsLoading());

    try {
      if (config.platform == PlatformConfig.android) {
        await _repository.configureAndroid(config.path, config.apiKey);
      } else if (config.platform == PlatformConfig.iOS) {
        await _repository.configureIOS(config.path, config.apiKey);
      }

      emit(GoogleMapsSuccess());
    } catch (e) {
      emit(GoogleMapsFailure(e.toString()));
    }
  }
}
