part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogLoading extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogFailure extends BlogState {
  @override
  List<Object> get props => [error];
  final String error;
  const BlogFailure(this.error);
}

final class BlogUploadSuccess extends BlogState {}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  const BlogDisplaySuccess(this.blogs);

  @override
  List<Object> get props => [blogs];
}
