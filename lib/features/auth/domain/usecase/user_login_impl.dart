import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/core/entities/profile.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';

@LazySingleton()
class UserLoginImpl implements UseCase<Profile, UserLoginParams> {
  final AuthRepository authRepository;
  UserLoginImpl(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(UserLoginParams params) async {
    return await authRepository.logInWithEmailPassword(
      email: params.email,
      passWord: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
