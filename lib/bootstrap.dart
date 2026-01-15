import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import 'core/bloc_observer/bloc_observer.dart';
import 'di/init_dependencies.dart';

/// Bootstrap the application with necessary initializations
///
/// This function handles:
/// - Dependency injection setup
/// - Firebase initialization (if needed)
/// - Error handling during startup
/// - Running the app
FutureOr<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Bloc.observer = AppBlocObserver();
      final dir = await getApplicationDocumentsDirectory();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(dir.path),
      );

      await initDependencies();

      // Run the app
      final rootWidget = await builder();
      runApp(rootWidget);
    },
    (error, stackTrace) async {
      log(
        'Uncaught Error',
        error: error,
        stackTrace: stackTrace,
        name: 'Bootstrap',
      );
    },
  );
}
