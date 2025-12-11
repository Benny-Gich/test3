import 'dart:io';
import 'package:test3/features/blog/data/models/blog_model.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    BlogModel? blog,
  });
  Future<List<Blog>> getAllBlogs();
}
