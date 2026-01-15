import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:test3/core/error/exception.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/network/connection_checker.dart';
import 'package:test3/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:test3/features/blog/data/models/blog_model.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  InternetStatus internetStatus;

  BlogRepositoryImpl(
    this.blogRemoteDataSource,

    this.internetStatus,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File? image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required String blogId,
  }) async {
    try {
      if (internetStatus != InternetStatus.connected) {
        return left(Failure('No internet Connection!'));
      }
      BlogModel blogModel = BlogModel(
        id: blogId,
        updatedAt: DateTime.now(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
      );
      String? imageUrl;
      if (image != null) {
        imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image,
          blog: blogModel,
        );
      }
      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    // try {
    //   if (internetStatus != InternetStatus.connected) {
    //     final blogs = blogLocalDataSource.loadBlogs();
    //     return right(blogs);
    //   }
    //   final blogs = await blogRemoteDataSource.getAllBlogs();
    //   blogLocalDataSource.uploadLocalBlogs(blogs: blogs as List<BlogModel>);
    //   return right(blogs);
    // }
    return left(Failure());
  }
}
