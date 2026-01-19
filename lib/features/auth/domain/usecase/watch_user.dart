import 'package:injectable/injectable.dart';
import 'package:test3/core/entities/auth_entity.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';

@LazySingleton()
class WatchUserUseCase {
  final AuthRepository authRepository;

  WatchUserUseCase(this.authRepository);

  Stream<AuthEntity> call() => authRepository.watchUser();
}
