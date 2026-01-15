import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:test3/core/error/exception.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test3/core/entities/profile.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDatasource;
  
  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Profile>> logInWithEmailPassword({
    required String email,
    required String passWord,
  }) async {
    try {
      final profile = await remoteDatasource.logInWithEmailPassWord(
        email: email,
        passWord: passWord,
      );
      return right(profile);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String passWord,
  }) async {
    try {
      final profile = await remoteDatasource.signUpwithEmailPassWord(
        name: name,
        email: email,
        passWord: passWord,
      );
      return right(profile);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> currentUser() async {
    try {
      final profile = await remoteDatasource.getCurrentUserData();
      if (profile == null) {
        return left(Failure('User not logged In'));
      }
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
