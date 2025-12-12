import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test3/features/blog/presentation/pages/blog_page_viewer.dart';
import 'package:test3/features/blog/presentation/pages/home_page.dart';
import 'package:test3/features/auth/presentation/pages/login_page.dart';
import 'package:test3/features/auth/presentation/pages/signup_page.dart';
import 'package:test3/features/auth/presentation/pages/splash_page.dart';
import 'package:test3/features/blog/presentation/pages/add_new_blog.dart';
import 'package:test3/features/blog/presentation/pages/blog_page.dart';

class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});
  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: SplashPage.route,
      builder: (context, data) => SplashPage(),
      path: SplashPage.path,
      initial: true,
    ),
    NamedRouteDef(
      name: HomePage.route,
      builder: (context, data) => HomePage(),
      path: HomePage.path,
    ),
    NamedRouteDef(
      name: LogInPage.route,
      builder: (context, data) => LogInPage(),
      path: LogInPage.path,
    ),
    NamedRouteDef(
      name: SignUpPage.route,
      builder: (context, data) => SignUpPage(),
      path: SignUpPage.path,
    ),
    NamedRouteDef(
      name: AddNewBlog.route,
      builder: (context, data) => AddNewBlog(),
      path: AddNewBlog.path,
    ),
    NamedRouteDef(
      name: BlogPage.route,
      builder: (context, data) => BlogPage(),
      path: BlogPage.path,
    ),
    NamedRouteDef(
      name: BlogPageViewer.route,
      path: BlogPageViewer.path,
      builder: (context, data) {
        final args = data.argsAs<BlogPageViewerArgs?>(
          orElse: () => null,
        );
        if (args == null) {
          //return an error Screen saying arguments is null
          return Scaffold(
            body: Center(
              child: Text('Arguments is null'),
            ),
          );
        }
        return BlogPageViewer(
          blog: args.blog,
        );
      },
    ),
  ];
}
