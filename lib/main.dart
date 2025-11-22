import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/core/app_secrets/app_secrets.dart';
import 'package:test3/core/bloc_observer/bloc_observer.dart';
import 'package:test3/core/theme/theme.dart';
import 'package:test3/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test3/features/auth/presentation/pages/login_page.dart';
import 'package:test3/features/auth/presentation/pages/signup_page.dart';
import 'package:test3/features/blog/di/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await initDependencies();
  await Supabase.initialize(
    url: AppSecrets.supabaseurl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event after the first frame so `context` can safely
    // access inherited widgets (BlocProvider). Calling `context.read` in
    // `initState` can fail because the element tree isn't fully built yet.
    context.read<AuthBloc>().add(const AuthIsUserLoggedIn());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          LogInPage.route => MaterialPageRoute(
            builder: (context) => LogInPage(),
          ),
          SignUpPage.route => MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
          _ => null,
        };
      },
      theme: AppTheme.darkThemeMode,
      home: const LogInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
