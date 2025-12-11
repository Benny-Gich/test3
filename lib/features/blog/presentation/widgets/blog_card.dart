import 'package:flutter/material.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blogs;
  final Color color;

  const BlogCard({super.key, required this.blogs, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 200,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
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
          Text(blogs.title),
        ],
      ),
    );
  }
}
