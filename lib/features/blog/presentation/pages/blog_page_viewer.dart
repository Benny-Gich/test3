import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test3/core/theme/app_pallete.dart';
import 'package:test3/core/utils/calculate_reading_time.dart';
import 'package:test3/core/utils/format_date.dart';
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Text('By ${blog.posterName}'),
                SizedBox(height: 5),
                Text(
                  '${formatDateBydMMMMyyyy(blog.updatedAt)}.${calculateReadingTime(blog.content)} min',
                  style: TextStyle(
                    color: AppPallete.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 40,
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 40,
                ),
                SizedBox(height: 20),
                Text(
                  blog.content,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
