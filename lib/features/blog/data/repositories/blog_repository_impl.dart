import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:test3/core/error/exception.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:test3/features/blog/data/models/blog_model.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        updatedAt: DateTime.now(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
