import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/core/app_secrets/app_secrets.dart';
import 'package:test3/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:test3/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test3/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:test3/features/auth/data/repository/auth_repository_impl.dart';
import 'package:test3/features/auth/domain/repository/auth_repository.dart';
import 'package:test3/features/auth/domain/usecase/current_user.dart';
import 'package:test3/features/auth/domain/usecase/user_login_impl.dart';
import 'package:test3/features/auth/domain/usecase/user_signup_impl.dart';
import 'package:test3/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseurl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<UserSignUpImpl>(
    () => UserSignUpImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<UserLoginImpl>(
    () => UserLoginImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<CurrentUser>(
    () => CurrentUser(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AppUserCubit>(() => serviceLocator());

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUpImpl: serviceLocator(),
      userLoginImpl: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
