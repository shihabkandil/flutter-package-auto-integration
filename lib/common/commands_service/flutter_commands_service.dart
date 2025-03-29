import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'i_flutter_commands_service.dart';

class FlutterCommandsService implements IFlutterCommandsService {
  @override
  Future<void> runPubGet() async {
    final process = await Process.start('flutter', [
      'pub',
      'get',
    ], workingDirectory: Directory.current.path);
    process.stdout.transform(Utf8Decoder()).listen((data) {
      log(data);
    });
    process.stderr.transform(Utf8Decoder()).listen((data) {
      log(data);
    });
  }
}
