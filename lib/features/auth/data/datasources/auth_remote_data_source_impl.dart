import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:test3/core/error/exception.dart';
import 'package:test3/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test3/features/auth/data/models/profile_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<ProfileModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        // Use a small helper to allow easier testing (can be overridden in tests)
        final profileData = await queryProfileById(currentUserSession!.user.id);
        return ProfileModel.fromJson(profileData.first);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
    return null;
  }

  /// Separated out to make `getCurrentUserData` easier to test without having
  /// to mock the entire Supabase query builder chain. Override in tests.
  @visibleForTesting
  Future<List<Map<String, dynamic>>> queryProfileById(String id) async {
    return await supabaseClient.from('profiles').select().eq('id', id);
  }

  @override
  Future<ProfileModel> logInWithEmailPassWord({
    required String email,
    required String passWord,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: passWord,
        email: email,
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProfileModel> signUpwithEmailPassWord({
    required String name,
    required String email,
    required String passWord,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: passWord,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
