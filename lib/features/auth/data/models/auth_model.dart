// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:test3/features/auth/data/models/profile_model.dart';

class AuthModel extends Equatable {
  final AuthChangeEvent status;
  final ProfileModel? profile;
  const AuthModel({
    required this.status,
    this.profile,
  });

  @override
  List<Object?> get props => [status, profile];
}
