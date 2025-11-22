// ignore_for_file: unused_field
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/features/auth/domain/entities/profile.dart';
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
  }) : _userSignUpImpl = userSignUpImpl,
       _userLoginImpl = userLoginImpl,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }
  final UserSignUpImpl _userSignUpImpl;
  final UserLoginImpl _userLoginImpl;
  final CurrentUser _currentUser;

  void _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _currentUser(Params());

    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }

  FutureOr<void> _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _userSignUpImpl(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.passWord,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => emit(AuthSuccess(profile)),
    );
  }

  FutureOr<void> _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLoginImpl(
      UserLoginParams(email: event.email, password: event.passWord),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => emit(AuthSuccess(profile)),
    );
  }
}
