import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/core/app_secrets/app_secrets.dart';
import 'package:test3/di/init_dependencies.config.dart';

final serviceLocator = GetIt.instance;

@module
abstract class AppModule {
  @preResolve
  Future<Supabase> get supabase => Supabase.initialize(
    url: AppSecrets.supabaseurl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  @lazySingleton
  SupabaseClient client(Supabase supabase) => supabase.client;
}

@InjectableInit()
Future<void> initDependencies() async {
  await serviceLocator.init();
  // serviceLocator.registerLazySingletonAsync<Supabase>(
  //   () => Supabase.initialize(
  //     url: AppSecrets.supabaseurl,
  //     anonKey: AppSecrets.supabaseAnonKey,
  //   ),
  // );

  // await serviceLocator.isReady<Supabase>();

  // // serviceLocator.registerLazySingleton(() => Hive.box('blogs'));
  // serviceLocator.registerLazySingleton<SupabaseClient>(
  //   () => serviceLocator<Supabase>().client,
  // );
  // serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(
  //     supabaseClient: serviceLocator<SupabaseClient>(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()),
  // );
  // serviceLocator.registerLazySingleton<UserSignUpImpl>(
  //   () => UserSignUpImpl(serviceLocator<AuthRepository>()),
  // );
  // serviceLocator.registerLazySingleton<UserLoginImpl>(
  //   () => UserLoginImpl(serviceLocator<AuthRepository>()),
  // );
  // serviceLocator.registerLazySingleton<CurrentUser>(
  //   () => CurrentUser(serviceLocator<AuthRepository>()),
  // );

  // serviceLocator.registerLazySingleton<AppUserCubit>(AppUserCubit.new);

  // serviceLocator.registerLazySingleton<AuthBloc>(
  //   () => AuthBloc(
  //     userSignUpImpl: serviceLocator<UserSignUpImpl>(),
  //     userLoginImpl: serviceLocator<UserLoginImpl>(),
  //     currentUser: serviceLocator<CurrentUser>(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton<BlogRemoteDataSource>(
  //   () => BlogRemoteDataSourceImpl(serviceLocator()),
  // );
  // // serviceLocator.registerLazySingleton<BlogLocalDataSource>(
  // //   () => BlogLocalDataSourceImpl(serviceLocator()),
  // // );
  // serviceLocator.registerLazySingleton<InternetStatus>(
  //   () => InternetStatus.connected,
  // );
  // serviceLocator.registerLazySingleton<BlogRepository>(
  //   () => BlogRepositoryImpl(
  //     serviceLocator(),
  //     serviceLocator(),

  //   ),
  // );
  // serviceLocator.registerLazySingleton<UploadBlog>(
  //   () => UploadBlog(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<GetAllBlogs>(
  //   () => GetAllBlogs(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<BlogBloc>(
  //   () => BlogBloc(
  //     uploadBlog: serviceLocator(),
  //     getAllBlogs: serviceLocator(),
  //   ),
  // );
}
