import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/supported_package.dart';
import '../../integration_strategy/cubits/integration_strategy_cubit/integration_strategy_cubit.dart';
import '../../integration_strategy/presentation/widgets/package_dropdown.dart';
import '../../integration_strategy/presentation/widgets/package_to_widget.dart';
import '../cubits/project_picker_cubit/project_picker_cubit.dart';
import 'widgets/project_selection_success_text.dart';
import 'widgets/start_integration_button.dart';

class ProjectPickerScreen extends StatelessWidget {
  const ProjectPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProjectPickerCubit()),
        BlocProvider(create: (context) => IntegrationStrategyCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Pick Flutter Project')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final didIntegrationStarted =
                  context.read<IntegrationStrategyCubit>().didIntegrationStart;
              return Column(
                spacing: 16,
                children: [
                  BlocBuilder<ProjectPickerCubit, ProjectPickerState>(
                    builder: (context, state) {
                      final path =
                          context.read<ProjectPickerCubit>().selected();
                      return Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: TextEditingController(text: path),
                            decoration: const InputDecoration(
                              labelText: 'Selected Folder',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                          ),

                          if (state is ProjectPickerError)
                            Text(
                              state.errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),

                          if (state is ProjectPickerSuccess) ...[
                            ProjectSelectionSuccessText(),
                            PackagesDropdown(
                              items: SupportedPackage.values,
                              onChanged:
                                  (value) => context
                                      .read<IntegrationStrategyCubit>()
                                      .setPackage(value),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed:
                          () => context.read<ProjectPickerCubit>().pickFolder(),
                      icon: const Icon(Icons.folder_open),
                      label: const Text('Browse'),
                    ),
                  ),
                  Divider(height: 40),
                  StartIntegrationButton(),
                  SizedBox(height: 32),
                  BlocBuilder<
                    IntegrationStrategyCubit,
                    IntegrationStrategyState
                  >(
                    builder: (context, state) {
                      if (state is IntegrationStrategyStarted) {
                        return PackageToWidget(
                          package: state.package,
                          path: state.directoryPath,
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
