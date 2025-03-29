import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/project_picker_cubit/project_picker_cubit.dart';
import 'widgets/project_selection_success_text.dart';

class ProjectPickerScreen extends StatelessWidget {
  const ProjectPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectPickerCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pick Flutter Project')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  BlocBuilder<ProjectPickerCubit, ProjectPickerState>(
                    builder: (context, state) {
                      final path =
                          context.read<ProjectPickerCubit>().selected();
                      return Column(
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

                          if (state is ProjectPickerSuccess)
                            ProjectSelectionSuccessText(),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
