import 'package:test3/features/auth/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.email,
    required super.password,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
  Profile copyWith({String? id, String? email, String? password}) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
