import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/core/entities/profile.dart';
import 'package:test3/features/auth/domain/usecase/watch_user.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

@LazySingleton()
class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc(this.watchUser) : super(const AppUserState()) {
    on<GetUserEvent>(_onGetUserEvent);
  }

  final WatchUserUseCase watchUser;

  FutureOr<void> _onGetUserEvent(
    GetUserEvent event,
    Emitter<AppUserState> emit,
  ) async {
    await emit.forEach(
      watchUser.call(),
      onData: (data) {
        final status = _mapAuthEvent(data.status);
        return AppUserState(
          status: status,
          profile: data.profile,
        );
      },
      onError: (error, stackTrace) {
        return AppUserState(status: AuthStatus.logout);
      },
    );
  }
}

AuthStatus _mapAuthEvent(AuthChangeEvent event) {
  switch (event) {
    case AuthChangeEvent.signedIn:
    case AuthChangeEvent.tokenRefreshed:
    case AuthChangeEvent.userUpdated:
      return AuthStatus.login;

    case AuthChangeEvent.signedOut:
      return AuthStatus.logout;

    default:
      return AuthStatus.initial;
  }
}
