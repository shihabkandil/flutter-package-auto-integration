import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'common/commands_service/flutter_commands_service.dart';
import 'common/commands_service/i_flutter_commands_service.dart';
import 'features/google_maps/data/google_maps_repository.dart';
import 'features/google_maps/data/i_google_maps_repository.dart';
import 'features/project_selection/data/folder_repository.dart';
import 'features/project_selection/data/i_folder_repository.dart';
import 'features/project_selection/presentation/project_picker_screen.dart';
import 'logger_bloc_observer.dart';

Future<void> main() async {
  await setupInjector();

  if (kDebugMode) {
    Bloc.observer = LoggerBlocObserver();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project Package Automation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ProjectPickerScreen(),
    );
  }
}

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  getIt.registerSingleton<IFlutterCommandsService>(FlutterCommandsService());
  getIt.registerSingleton<IGoogleMapsRepository>(GoogleMapsRepository());
  getIt.registerSingleton<IFolderRepository>(FolderRepository());

  await getIt.allReady();
}
