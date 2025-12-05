import 'dart:io';
import 'package:test3/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    File image,
    BlogModel blog,
  });
}
