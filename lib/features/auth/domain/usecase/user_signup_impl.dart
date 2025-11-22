// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/features/auth/domain/entities/profile.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';

class UserSignUpImpl implements UseCase<Profile, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUpImpl(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      passWord: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
