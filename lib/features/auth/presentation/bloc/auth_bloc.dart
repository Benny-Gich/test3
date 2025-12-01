// ignore_for_file: unused_field
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/core/entities/profile.dart';
import 'package:test3/features/auth/domain/usecase/current_user.dart';
import 'package:test3/features/auth/domain/usecase/user_login_impl.dart';
import 'package:test3/features/auth/domain/usecase/user_signup_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CurrentUser currentUser,
    required UserSignUpImpl userSignUpImpl,
    required UserLoginImpl userLoginImpl,
   // required AppUserCubit appUserCubit,
  }) : _userSignUpImpl = userSignUpImpl,
       _userLoginImpl = userLoginImpl,
       _currentUser = currentUser,
      // _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }
  final UserSignUpImpl _userSignUpImpl;
  final UserLoginImpl _userLoginImpl;
  final CurrentUser _currentUser;
 // final AppUserCubit _appUserCubit;

  FutureOr<void> _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(Params());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  FutureOr<void> _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUpImpl(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.passWord,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  FutureOr<void> _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    final res = await _userLoginImpl(
      UserLoginParams(email: event.email, password: event.passWord),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  void _emitAuthSuccess(Profile profile, Emitter<AuthState> emit) {
    // _appUserCubit.updateProfile(profile);
    emit(AuthSuccess(profile));
  }
}
