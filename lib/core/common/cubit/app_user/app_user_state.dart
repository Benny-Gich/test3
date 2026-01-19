part of 'app_user_bloc.dart';

class AppUserState extends Equatable {
  const AppUserState({
    this.status = AuthStatus.initial,
    this.profile,
  });
  final AuthStatus status;
  final Profile? profile;

  @override
  List<Object?> get props => [status, profile];
}

enum AuthStatus { initial, loading, login, logout }
