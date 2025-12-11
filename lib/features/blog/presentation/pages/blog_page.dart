import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test3/features/blog/presentation/pages/add_new_blog.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});
  static String route = 'BlogPage';
  static String path = '/blog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Use the route name (defined on the page) rather than the path
              // AutoRoute's NamedRoute expects the route name, not the path string
              context.router.navigate(NamedRoute(AddNewBlog.route));
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Column(),
    );
  }
}
