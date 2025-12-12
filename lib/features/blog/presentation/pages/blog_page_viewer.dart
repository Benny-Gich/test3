import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';

class BlogPageViewerArgs {
  final Blog blog;
  const BlogPageViewerArgs({required this.blog});
}

class BlogPageViewer extends StatelessWidget {
  final Blog blog;
  const BlogPageViewer({super.key, required this.blog});
  static String route = 'blogview';
  static String path = '/view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.router.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          blog.title,
          overflow: TextOverflow.fade,
          maxLines: 1,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(12),
            ),
            SizedBox(
              height: 200,
              child: Image.network(blog.imageUrl),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
