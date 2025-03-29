import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../data/i_folder_repository.dart';

part 'project_picker_state.dart';

class ProjectPickerCubit extends Cubit<ProjectPickerState> {
  ProjectPickerCubit({IFolderRepository? repository})
    : _repository = repository ?? getIt<IFolderRepository>(),
      super(ProjectPickerInitial());

  final IFolderRepository _repository;

  void pickFolder() async {
    final selectionResult = await _repository.pickProjectPath();

    selectionResult.fold(
      (error) {
        emit(ProjectPickerError(error));
      },
      (directory) {
        if (directory?.isEmpty ?? true) {
          emit(ProjectPickerError("Folder path isn't correct"));
          return;
        }
        verifyIsFlutterProject(directory!);
      },
    );
  }

  void verifyIsFlutterProject(String directory) {
    if (_repository.isPubspecExists(directory)) {
      emit(ProjectPickerSuccess(directory));
    } else {
      emit(
        ProjectPickerError(
          'Please make sure its a Flutter project directory',
          directoryPath: directory,
        ),
      );
    }
  }

  String? selected() {
    if (state is ProjectPickerSuccess) {
      return (state as ProjectPickerSuccess).directoryPath;
    }

    if (state is ProjectPickerError) {
      return (state as ProjectPickerError).directoryPath;
    }
    return null;
  }
}
