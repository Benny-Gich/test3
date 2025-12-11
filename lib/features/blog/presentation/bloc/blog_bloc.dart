// ignore_for_file: unused_import

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/features/blog/domain/usecase/upload_blog.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(
    this.uploadBlog,
  ) : super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final res = await uploadBlog(
        UploadBlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics,
        ),
      );
      res.fold(
        (l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogSuccess()),
      );
    } catch (e) {
      emit(BlogFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
