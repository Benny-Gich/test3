//import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/entities/profile.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateProfile(Profile? profile) {
    if (profile == null) {
      emit(AppUserInitial());
    } else {
      (emit(AppUserLoggedIn(profile)));
    }
  }
}
