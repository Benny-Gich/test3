import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/bootstrap.dart';
import 'package:test3/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:test3/core/theme/theme.dart';
import 'package:test3/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test3/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:test3/features/blog/presentation/pages/blog_page.dart';
import 'package:test3/features/auth/presentation/pages/login_page.dart';
import 'package:test3/di/init_dependencies.dart';
import 'package:test3/router/app_router.dart';

void main() async {
  bootstrap(() => RootAppWidget());
}

class RootAppWidget extends StatelessWidget {
  const RootAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],

      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  late final AppRouter appRouter;

  @override
  void initState() {
    super.initState();

    appRouter = AppRouter(navigatorKey: navigatorKey);

    // Dispatch the event after the first frame so `context` can safely
    // access inherited widgets (BlocProvider). Calling `context.read` in
    // `initState` can fail because the element tree isn't fully built yet.

    context.read<AuthBloc>().add(const AuthIsUserLoggedIn());
  }

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<AppUserCubit>().updateProfile(state.profile);
            }
          },
        ),
        BlocListener<AppUserCubit, AppUserState>(
          listener: (context, state) {
            if (state is AppUserLoggedIn) {
              appRouter.replaceAll([NamedRoute(BlogPage.route)]);
            } else {
              appRouter.replaceAll([NamedRoute(LogInPage.route)]);
            }
          },
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.darkThemeMode,
        routerConfig: appRouter.config(),

        /*home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return HomePage();
            }
            return const LogInPage();
          },
        ),*/
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
