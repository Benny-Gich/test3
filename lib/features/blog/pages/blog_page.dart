import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test3/features/blog/pages/add_new_blog.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});
  static String route = 'BlogPage';
  static String path='/blog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogg App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.router.navigate(NamedRoute(AddNewBlog.path));
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}
