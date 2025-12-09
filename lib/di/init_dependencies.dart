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
import 'package:test3/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:test3/features/blog/data/datasources/blog_remote_data_source_impl.dart';
import 'package:test3/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:test3/features/blog/domain/repositories/blog_repository.dart';
import 'package:test3/features/blog/domain/usecase/upload_blog.dart';
import 'package:test3/features/blog/presentation/bloc/blog_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // final supabase = await
  serviceLocator.registerLazySingletonAsync<Supabase>(
    () => Supabase.initialize(
      url: AppSecrets.supabaseurl,
      anonKey: AppSecrets.supabaseAnonKey,
    ),
  );
  await serviceLocator.isReady<Supabase>();
  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => serviceLocator<Supabase>().client,
  );
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator<SupabaseClient>(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()),
  );
  serviceLocator.registerLazySingleton<UserSignUpImpl>(
    () => UserSignUpImpl(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerLazySingleton<UserLoginImpl>(
    () => UserLoginImpl(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerLazySingleton<CurrentUser>(
    () => CurrentUser(serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerLazySingleton<AppUserCubit>(AppUserCubit.new);

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUpImpl: serviceLocator<UserSignUpImpl>(),
      userLoginImpl: serviceLocator<UserLoginImpl>(),
      currentUser: serviceLocator<CurrentUser>(),
    ),
  );
  serviceLocator.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UploadBlog>(
    () => UploadBlog(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<BlogBloc>(
    () => BlogBloc(serviceLocator()),
  );
}
