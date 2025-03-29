import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/supported_package.dart';

part 'integration_strategy_state.dart';

class IntegrationStrategyCubit extends Cubit<IntegrationStrategyState> {
  IntegrationStrategyCubit() : super(IntegrationStrategyInitial());

  bool get didIntegrationStart => state is IntegrationStrategyStarted;

  void setPackage(SupportedPackage? package) {
    if (package == null) return;
    emit(IntegrationStrategySelected(package: package));
  }

  void startIntegration(String directoryPath) {
    if (state is IntegrationStrategySelected) {
      emit(
        IntegrationStrategyStarted(
          package: (state as IntegrationStrategySelected).package,
          directoryPath: directoryPath,
        ),
      );
    } else {
      emit(IntegrationStrategyError(error: 'Please select a package'));
    }
  }

  void reset() {
    emit(IntegrationStrategyInitial());
  }
}
