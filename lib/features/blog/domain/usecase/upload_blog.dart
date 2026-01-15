import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
      blogId: params.blogId,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File? image;
  final List<String> topics;
  final String blogId;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.blogId,
  });
}
