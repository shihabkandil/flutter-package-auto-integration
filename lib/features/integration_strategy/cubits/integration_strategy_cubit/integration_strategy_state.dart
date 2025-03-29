part of 'integration_strategy_cubit.dart';

@immutable
sealed class IntegrationStrategyState {
  const IntegrationStrategyState();
}

class IntegrationStrategyInitial extends IntegrationStrategyState {
  const IntegrationStrategyInitial();
}

class IntegrationStrategySelected extends IntegrationStrategyState {
  const IntegrationStrategySelected({required this.package});
  final SupportedPackage package;
}

class IntegrationStrategyStarted extends IntegrationStrategyState {
  const IntegrationStrategyStarted({
    required this.package,
    required this.directoryPath,
  });

  final SupportedPackage package;
  final String directoryPath;
}

class IntegrationStrategyError extends IntegrationStrategyState {
  const IntegrationStrategyError({required this.error});
  final String error;
}
