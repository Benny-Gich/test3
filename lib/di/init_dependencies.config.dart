// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:test3/core/common/cubit/app_user/app_user_bloc.dart' as _i706;
import 'package:test3/core/network/connection_checker.dart' as _i870;
import 'package:test3/di/init_dependencies.dart' as _i933;
import 'package:test3/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i67;
import 'package:test3/features/auth/data/datasources/auth_remote_data_source_impl.dart'
    as _i516;
import 'package:test3/features/auth/data/repository/auth_repository_impl.dart'
    as _i985;
import 'package:test3/features/auth/domain/repository/auth_repository.dart'
    as _i382;
import 'package:test3/features/auth/domain/usecase/current_user.dart' as _i875;
import 'package:test3/features/auth/domain/usecase/logout.dart' as _i181;
import 'package:test3/features/auth/domain/usecase/user_login_impl.dart'
    as _i337;
import 'package:test3/features/auth/domain/usecase/user_signup_impl.dart'
    as _i667;
import 'package:test3/features/auth/domain/usecase/watch_user.dart' as _i803;
import 'package:test3/features/auth/presentation/bloc/auth_bloc.dart' as _i974;
import 'package:test3/features/blog/data/datasources/blog_remote_data_source.dart'
    as _i12;
import 'package:test3/features/blog/data/datasources/blog_remote_data_source_impl.dart'
    as _i374;
import 'package:test3/features/blog/data/repositories/blog_repository_impl.dart'
    as _i63;
import 'package:test3/features/blog/domain/repositories/blog_repository.dart'
    as _i161;
import 'package:test3/features/blog/domain/usecase/get_all_blogs.dart' as _i745;
import 'package:test3/features/blog/domain/usecase/upload_blog.dart' as _i913;
import 'package:test3/features/blog/presentation/bloc/blog_bloc.dart' as _i159;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i454.Supabase>(
      () => appModule.supabase,
      preResolve: true,
    );
    gh.lazySingleton<_i870.InternetConnection>(
      () => _i870.InternetConnection(),
    );
    gh.lazySingleton<_i454.SupabaseClient>(
      () => appModule.client(gh<_i454.Supabase>()),
    );
    gh.lazySingleton<_i67.AuthRemoteDataSource>(
      () => _i516.AuthRemoteDataSourceImpl(supabase: gh<_i454.Supabase>()),
    );
    gh.lazySingleton<_i12.BlogRemoteDataSource>(
      () => _i374.BlogRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i161.BlogRepository>(
      () => _i63.BlogRepositoryImpl(gh<_i12.BlogRemoteDataSource>()),
    );
    gh.lazySingleton<_i745.GetAllBlogs>(
      () => _i745.GetAllBlogs(gh<_i161.BlogRepository>()),
    );
    gh.lazySingleton<_i913.UploadBlog>(
      () => _i913.UploadBlog(gh<_i161.BlogRepository>()),
    );
    gh.lazySingleton<_i382.AuthRepository>(
      () => _i985.AuthRepositoryImpl(gh<_i67.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i159.BlogBloc>(
      () => _i159.BlogBloc(
        uploadBlog: gh<_i913.UploadBlog>(),
        getAllBlogs: gh<_i745.GetAllBlogs>(),
      ),
    );
    gh.lazySingleton<_i875.CurrentUser>(
      () => _i875.CurrentUser(gh<_i382.AuthRepository>()),
    );
    gh.lazySingleton<_i181.LogoutUseCase>(
      () => _i181.LogoutUseCase(gh<_i382.AuthRepository>()),
    );
    gh.lazySingleton<_i337.UserLoginImpl>(
      () => _i337.UserLoginImpl(gh<_i382.AuthRepository>()),
    );
    gh.lazySingleton<_i667.UserSignUpImpl>(
      () => _i667.UserSignUpImpl(gh<_i382.AuthRepository>()),
    );
    gh.lazySingleton<_i803.WatchUserUseCase>(
      () => _i803.WatchUserUseCase(gh<_i382.AuthRepository>()),
    );
    gh.lazySingleton<_i706.AppUserBloc>(
      () => _i706.AppUserBloc(gh<_i803.WatchUserUseCase>()),
    );
    gh.lazySingleton<_i974.AuthBloc>(
      () => _i974.AuthBloc(
        currentUser: gh<_i875.CurrentUser>(),
        userSignUpImpl: gh<_i667.UserSignUpImpl>(),
        userLoginImpl: gh<_i337.UserLoginImpl>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i933.AppModule {}
