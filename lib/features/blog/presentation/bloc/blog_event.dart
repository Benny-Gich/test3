part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

final class BlogGetAllBlogs extends BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  final String blogId;

  @override
  List<Object> get props => [
    posterId,
    title,
    content,
    image,
    topics,
    blogId,
  ];

  const BlogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.blogId,
  });
}

final class SyncUploads extends BlogEvent {
  const SyncUploads();
}

final class _SingleUploadEvent extends BlogEvent {
  final Blog blog;
  const _SingleUploadEvent(this.blog);

  @override
  List<Object> get props => [blog];
}
