// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String email;
  final String password;

  const Profile({
    required this.id,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [id, email, password];
}
