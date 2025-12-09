import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
