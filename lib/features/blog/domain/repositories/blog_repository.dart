import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}
