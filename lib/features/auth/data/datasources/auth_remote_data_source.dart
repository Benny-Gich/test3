import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/features/auth/data/models/profile_model.dart';

abstract interface class AuthRemoteDataSource {
  
  Session? get currentUserSession;
  Future<ProfileModel> signUpwithEmailPassWord({
    required String name,
    required String email,
    required String passWord,
  });
  Future<ProfileModel> logInWithEmailPassWord({
    required String email,
    required String passWord,
  });
  Future<ProfileModel?> getCurrentUserData();
}
