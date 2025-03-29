part of 'google_maps_integration_cubit.dart';

@immutable
sealed class GoogleMapsIntegrationState {}

class GoogleMapsInitial extends GoogleMapsIntegrationState {}

class GoogleMapsLoading extends GoogleMapsIntegrationState {}

class GoogleMapsDependencyAdded extends GoogleMapsIntegrationState {}

class GoogleMapsKeyNeeded extends GoogleMapsIntegrationState {
  GoogleMapsKeyNeeded(this.platform);
  final PlatformConfig platform;
}

class GoogleMapsSuccess extends GoogleMapsIntegrationState {}

class GoogleMapsFailure extends GoogleMapsIntegrationState {
  GoogleMapsFailure(this.error);
  final String error;
}
