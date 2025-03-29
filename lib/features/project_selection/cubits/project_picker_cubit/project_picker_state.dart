part of 'project_picker_cubit.dart';

@immutable
sealed class ProjectPickerState {}

final class ProjectPickerInitial extends ProjectPickerState {}

class ProjectPickerLoading extends ProjectPickerState {}

class ProjectPickerSuccess extends ProjectPickerState {
  ProjectPickerSuccess(this.directoryPath);
  final String directoryPath;
}

class ProjectPickerError extends ProjectPickerState {
  ProjectPickerError(this.errorMessage, {this.directoryPath});
  final String errorMessage;
  final String? directoryPath;
}
