import 'package:dartz/dartz.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/entities/profile.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Profile>> currentUser() {
    throw UnimplementedError();
  }

  Future<Either<Failure, Profile>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String passWord,
  });

  Future<Either<Failure, Profile>> logInWithEmailPassword({
    required String email,
    required String passWord,
  });
}
