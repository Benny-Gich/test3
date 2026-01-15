// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
  id: json['id'] as String,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  posterId: json['poster_id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  imageUrl: json['image_url'] as String,
  topics: (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
  posterName: json['poster_name'] as String?,
);

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
  'id': instance.id,
  'updated_at': instance.updatedAt?.toIso8601String(),
  'poster_id': instance.posterId,
  'title': instance.title,
  'poster_name': instance.posterName,
  'content': instance.content,
  'image_url': instance.imageUrl,
  'topics': instance.topics,
};
