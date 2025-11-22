part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String passWord;

  const AuthSignUp({
    required this.name,
    required this.email,
    required this.passWord,
  });

  @override
  List<Object?> get props => [name, email, passWord];
}

final class AuthIsUserLoggedIn extends AuthEvent {
  const AuthIsUserLoggedIn();

  @override
  List<Object?> get props => [];
}

final class AuthLogIn extends AuthEvent {
  final String email;
  final String passWord;

  const AuthLogIn({required this.email, required this.passWord});

  @override
  List<Object?> get props => [email, passWord];
}
