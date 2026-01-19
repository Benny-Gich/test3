part of 'app_user_bloc.dart';

sealed class AppUserEvent extends Equatable {
  const AppUserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends AppUserEvent{}