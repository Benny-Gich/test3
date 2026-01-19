import 'dart:async';
import 'dart:io';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:test3/features/blog/domain/usecase/upload_blog.dart';

import 'package:json_annotation/json_annotation.dart';

part 'blog_bloc.g.dart';

part 'blog_event.dart';
part 'blog_state.dart';

@LazySingleton()
class BlogBloc extends HydratedBloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlogs getAllBlogs;

  BlogBloc({
    required this.uploadBlog,
    required this.getAllBlogs,
  }) : super(BlogState()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
    on<SyncUploads>(_syncUploads);
    on<_SingleUploadEvent>(
      _singleUpload,
      transformer: sequential(),
    );
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final blog = Blog(
      id: event.blogId,
      updatedAt: DateTime.now(),
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      imageUrl: '',
      topics: event.topics,
      offlineId: event.blogId,
      offlineImagePath: event.image.path,
    );
    emit(
      state.copyWith(
        status: BlogStatus.loading,
      ),
    );
    try {
      final res = await uploadBlog(
        UploadBlogParams(
          blogId: event.blogId,
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics,
        ),
      );

      final Blog? successBlog = res.fold(
        (l) => null,
        (r) => r,
      );
      emit(
        state.copyWith(
          status: BlogStatus.success,
          blogs: [successBlog ?? blog, ...state.blogs],
        ),
      );
    } catch (e) {
      // emit(BlogFailure('Unexpected error: ${e.toString()}'));
      emit(
        state.copyWith(
          status: BlogStatus.success,
          blogs: [blog, ...state.blogs],
        ),
      );
    }
  }

  void _onGetAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    emit(
      state.copyWith(
        status: BlogStatus.loading,
      ),
    );
    final res = await getAllBlogs(Params());
    res.fold(
      (l) => emit(
        state.copyWith(
          status: BlogStatus.failure,
          error: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BlogStatus.success,

          ///sync superbase to offline
          blogs: [
            ...r,
            ...state.blogs,
          ].toImmutableList().distinctBy((e) => e.id).asList(),
        ),
      ),
    );
  }

  FutureOr<void> _syncUploads(SyncUploads event, Emitter<BlogState> emit) {
    final toUpload = state.blogs.where((e) => e.offlineId != null);
    for (final upload in toUpload) {
      add(_SingleUploadEvent(upload));
    }
  }

  FutureOr<void> _singleUpload(
    _SingleUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    final blog = event.blog;
    emit(
      state.copyWith(
        status: BlogStatus.loading,
      ),
    );
    final res = await uploadBlog(
      UploadBlogParams(
        blogId: blog.id,
        posterId: blog.posterId ?? '',
        title: blog.title??'',
        content: blog.content??'',
        image: blog.offlineImagePath?.let((path) => File(path)),
        topics: blog.topics,
      ),
    );
    final Blog? successBlog = res.fold(
      (l) => null,
      (r) => r,
    );
    emit(
      state.copyWith(
        status: BlogStatus.success,
        blogs: state.blogs.map((e) {
          if (successBlog != null && successBlog.id == e.id) {
            return successBlog;
          }
          return e;
        }).toList(),
      ),
    );
  }

  @override
  BlogState? fromJson(Map<String, dynamic> json) {
    return BlogState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BlogState state) {
    return state.toJson();
  }
}
