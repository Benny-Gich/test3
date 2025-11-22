import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Global BLoC observer for monitoring all BLoC events and errors
class AppBlocObserver extends BlocObserver {
  /// Creates an instance of [AppBlocObserver]
  const AppBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}', name: 'BlocObserver');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- ${bloc.runtimeType}, event: $event', name: 'BlocObserver');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log(
      'onChange -- ${bloc.runtimeType}, change: $change',
      name: 'BlocObserver',
    );
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log(
      'onTransition -- ${bloc.runtimeType}, transition: $transition',
      name: 'BlocObserver',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError -- ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
      name: 'BlocObserver',
    );

    // Report BLoC errors to Firebase Crashlytics
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}', name: 'BlocObserver');
  }
}
