import '../../../common/core/either.dart';

abstract class IFolderRepository {
  Future<Either<String, String?>> pickProjectPath();
  bool isPubspecExists(String directoryPath);
}
