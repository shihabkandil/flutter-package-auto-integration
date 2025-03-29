import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../integration_strategy/cubits/integration_strategy_cubit/integration_strategy_cubit.dart';
import '../../cubits/project_picker_cubit/project_picker_cubit.dart';

class StartIntegrationButton extends StatelessWidget {
  const StartIntegrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final didIntegrationStarted =
        context.watch<IntegrationStrategyCubit>().didIntegrationStart;

    return BlocListener<IntegrationStrategyCubit, IntegrationStrategyState>(
      listener: (context, state) {
        if (state is IntegrationStrategyError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<ProjectPickerCubit, ProjectPickerState>(
        builder: (context, state) {
          if (state is ProjectPickerSuccess) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    didIntegrationStarted
                        ? null
                        : () {
                          if (context.read<ProjectPickerCubit>().validate()) {
                            context
                                .read<IntegrationStrategyCubit>()
                                .startIntegration(state.directoryPath);
                          }
                        },
                icon: const Icon(Icons.settings_rounded),
                label: const Text('Start integrating...'),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
