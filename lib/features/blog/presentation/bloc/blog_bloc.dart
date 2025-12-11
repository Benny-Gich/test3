// ignore_for_file: unused_import

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:test3/features/blog/domain/usecase/upload_blog.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlogs getAllBlogs;

  BlogBloc({
    required this.uploadBlog,
    required this.getAllBlogs,
  }) : super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
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
        (r) => emit(BlogUploadSuccess()),
      );
    } catch (e) {
      emit(BlogFailure('Unexpected error: ${e.toString()}'));
    }
  }

  void _onGetAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    //emit(BlogLoading());
    final res = await getAllBlogs(Params());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
