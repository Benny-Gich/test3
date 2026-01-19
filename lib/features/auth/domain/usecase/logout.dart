import 'package:injectable/injectable.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';

@LazySingleton()
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<void> call()=>authRepository.logout();
}