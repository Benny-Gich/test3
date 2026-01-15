// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'blog_bloc.dart';

// sealed class BlogState extends Equatable {
//   const BlogState();

//   @override
//   List<Object> get props => [];
// }

// final class BlogInitial extends BlogState {
//   @override
//   List<Object> get props => [];
// }

// final class BlogLoading extends BlogState {
//   @override
//   List<Object> get props => [];
// }

// final class BlogFailure extends BlogState {
//   @override
//   List<Object> get props => [error];
//   final String error;
//   const BlogFailure(this.error);
// }

// final class BlogUploadSuccess extends BlogState {}

// final class BlogDisplaySuccess extends BlogState {
//   final List<Blog> blogs;
//   const BlogDisplaySuccess(this.blogs);

//   @override
//   List<Object> get props => [blogs];
// }

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class BlogState extends Equatable {
  const BlogState({
    this.status = BlogStatus.initial,
    this.blogs = const [],
    this.error = '',
  });
  final BlogStatus status;
  final List<Blog> blogs;
  final String error;

  factory BlogState.fromJson(Map<String, dynamic> json) =>
      _$BlogStateFromJson(json);

  Map<String, dynamic> toJson() => _$BlogStateToJson(this);

  @override
  List<Object> get props => [status, blogs, error];

  BlogState copyWith({
    BlogStatus? status,
    List<Blog>? blogs,
    String? error,
  }) {
    return BlogState(
      status: status ?? this.status,
      blogs: blogs ?? this.blogs,
      error: error ?? '',
    );
  }
}

enum BlogStatus { initial, loading, success, failure }
