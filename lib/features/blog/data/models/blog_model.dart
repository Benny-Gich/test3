// ignore_for_file: non_constant_identifier_names

import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.updatedAt,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    super.posterName,
  });
  

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      posterName: posterName ?? this.posterName,
    );
  }
}


