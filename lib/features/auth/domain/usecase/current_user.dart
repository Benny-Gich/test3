import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/core/entities/profile.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';

@LazySingleton()
class CurrentUser implements UseCase<Profile, Params> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(Params params) async {
    return await authRepository.currentUser();
  }
}
