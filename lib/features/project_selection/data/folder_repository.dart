import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../../common/core/either.dart';
import 'i_folder_repository.dart';

class FolderRepository implements IFolderRepository {
  @override
  Future<Either<String, String?>> pickProjectPath() async {
    try {
      return Right(await FilePicker.platform.getDirectoryPath());
    } catch (e) {
      log('Error selecting project', error: e);
      return Left('Problem picking Flutter project, please check permissions');
    }
  }

  @override
  bool isPubspecExists(String directoryPath) {
    try {
      final directory = Directory(directoryPath);
      final pubspecFile = File('${directory.path}/pubspec.yaml');
      return pubspecFile.existsSync();
    } catch (e) {
      log('Error checking file existence: $e');
      return false;
    }
  }
}
