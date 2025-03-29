import 'dart:developer';
import 'dart:io';

import '../../../common/commands_service/i_flutter_commands_service.dart';
import '../../../common/core/either.dart';
import '../../../main.dart';
import 'i_google_maps_repository.dart';

class GoogleMapsRepository implements IGoogleMapsRepository {
  GoogleMapsRepository({IFlutterCommandsService? commandsService})
    : _flutterCommandsService =
          commandsService ?? getIt<IFlutterCommandsService>();

  final IFlutterCommandsService _flutterCommandsService;

  @override
  Future<void> addGoogleMapsDependency(String projectPath) async {
    try {
      final pubspec = File('$projectPath/pubspec.yaml');
      String content = pubspec.readAsStringSync();

      if (!content.contains('google_maps_flutter:')) {
        // We don't specify version initially so flutter auto resolves any
        // version conflicts else it will be latest version
        content = content.replaceFirst(
          'dependencies:',
          'dependencies:\n  google_maps_flutter: ',
        );
        pubspec.writeAsStringSync(content);
        log('google_maps_flutter added to pubspec.yaml');

        await _flutterCommandsService.runPubGet();
      } else {
        log('google_maps_flutter is already in pubspec.yaml');
      }
    } catch (e) {
      log('Error updating pubspec.yaml file', error: e);
    }
  }

  @override
  bool isAndroidManifestContainsKey(String projectPath) {
    final androidManifest = File(
      '$projectPath/android/app/src/main/AndroidManifest.xml',
    );
    if (androidManifest.existsSync()) {
      String content = androidManifest.readAsStringSync();

      return content.contains('com.google.android.geo.API_KEY');
    }
    return false;
  }

  @override
  Future<void> configureAndroid(String projectPath, String apiKey) async {
    final androidManifest = File(
      '$projectPath/android/app/src/main/AndroidManifest.xml',
    );
    if (androidManifest.existsSync()) {
      String content = androidManifest.readAsStringSync();

      if (!isAndroidManifestContainsKey(projectPath)) {
        content = content.replaceFirst(
          '</application>',
          '<meta-data android:name="com.google.android.geo.API_KEY"'
              ' android:value="$apiKey" />\n</application>',
        );
        androidManifest.writeAsStringSync(content);
        log('API key added to AndroidManifest.xml');
      } else {
        log('API key already exists in AndroidManifest.xml');
      }
    } else {
      log('AndroidManifest.xml not found.');
    }
  }

  @override
  Future<void> configureIOS(String projectPath, String apiKey) async {
    final filePath = '$projectPath/ios/Runner/AppDelegate.swift';

    if (!File(filePath).existsSync()) {
      log('Error: AppDelegate.swift not found at $filePath');
    }

    final file = File(filePath);
    String content = file.readAsStringSync();

    if (isIOSApiKeyAlreadyAdded(projectPath)) {
      log('Google Maps API key is already added.');
      return;
    }

    content = _ensureIOSGoogleMapsImport(content);
    final contentResult = _addApiKeyToAppDelegate(content, apiKey);

    contentResult.fold(
      (left) => log('iOS config error:', error: left),
      (updatedContent) => content = updatedContent,
    );

    file.writeAsStringSync(content);
  }

  @override
  bool isIOSApiKeyAlreadyAdded(String projectPath) {
    final filePath = '$projectPath/ios/Runner/AppDelegate.swift';

    if (!File(filePath).existsSync()) {
      log('Error: AppDelegate.swift not found at $filePath');
    }

    final file = File(filePath);
    String content = file.readAsStringSync();
    return content.contains('GMSServices.provideAPIKey');
  }

  String _ensureIOSGoogleMapsImport(String content) {
    if (!content.contains('import GoogleMaps')) {
      return content.replaceFirst(
        'import Flutter',
        'import Flutter\nimport GoogleMaps',
      );
    }
    return content;
  }

  Either<String, String> _addApiKeyToAppDelegate(
    String content,
    String apiKey,
  ) {
    final launchOptionsPattern = RegExp(
      r'(didFinishLaunchingWithOptions[^}]*?)return super.application',
      dotAll: true,
    );

    if (launchOptionsPattern.hasMatch(content)) {
      return Right(
        content.replaceFirstMapped(
          launchOptionsPattern,
          (match) =>
              '${match.group(1)!}\n'
              'GMSServices.provideAPIKey("$apiKey");\n'
              'return super.application',
        ),
      );
    } else {
      return Left('Error: Unable to find iOS configuration');
    }
  }
}
