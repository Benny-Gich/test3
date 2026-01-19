import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test3/core/utils/calculate_reading_time.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/presentation/pages/blog_page_viewer.dart';

class BlogCard extends StatelessWidget {
  final Blog blogs;
  final Color color;
  const BlogCard({
    super.key,
    required this.blogs,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.navigate(
          NamedRoute(
            BlogPageViewer.route,
            args: BlogPageViewerArgs(blog: blogs),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        height: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: blogs.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: Text(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blogs.title??'',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text('${calculateReadingTime(blogs.content)} min'),
          ],
        ),
      ),
    );
  }
}
