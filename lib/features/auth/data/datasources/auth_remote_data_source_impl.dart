import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:test3/core/error/exception.dart';
import 'package:test3/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test3/features/auth/data/models/auth_model.dart';
import 'package:test3/features/auth/data/models/profile_model.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Supabase supabase;
  AuthRemoteDataSourceImpl({required this.supabase});

  SupabaseClient get supabaseClient => supabase.client;
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<ProfileModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        // Use a small helper to allow easier testing (can be overridden in tests)
        final profileData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return ProfileModel.fromJson(profileData.first);
      }
    } catch (e) {
      // throw ServerException(e.toString());
      return null;
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

  @override
  Stream<AuthModel> watchCurrentUser() async* {
    final initialUser = supabaseClient.auth.currentUser;

    // Always yield initial state
    if (initialUser == null) {
      yield AuthModel(status: AuthChangeEvent.signedOut);
    } else {
      // Fetch profile data for the initial user
      final profile = await _getProfileData(initialUser.id);
      yield AuthModel(status: AuthChangeEvent.signedIn, profile: profile);
    }

    // Then listen to subsequent changes
    yield* supabase.client.auth.onAuthStateChange.asyncMap((state) async {
      final event = state.event;
      final session = state.session;
      if (session?.user == null) {
        return AuthModel(status: event);
      }
      log('STATUS $event');
      final profile = await _getProfileData(session?.user.id);
      return AuthModel(status: event, profile: profile);
    }).distinct();
  }

  Future<ProfileModel?> _getProfileData(String? userId) async {
    try {
      if (userId == null) {
        return null;
      }
      final profileData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      if (profileData != null) {
        return ProfileModel.fromJson(profileData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logout() {
    return supabaseClient.auth.signOut();
  }
}
