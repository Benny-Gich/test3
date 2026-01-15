// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogState _$BlogStateFromJson(Map<String, dynamic> json) => BlogState(
  status:
      $enumDecodeNullable(_$BlogStatusEnumMap, json['status']) ??
      BlogStatus.initial,
  blogs:
      (json['blogs'] as List<dynamic>?)
          ?.map((e) => Blog.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  error: json['error'] as String? ?? '',
);

Map<String, dynamic> _$BlogStateToJson(BlogState instance) => <String, dynamic>{
  'status': _$BlogStatusEnumMap[instance.status]!,
  'blogs': instance.blogs.map((e) => e.toJson()).toList(),
  'error': instance.error,
};

const _$BlogStatusEnumMap = {
  BlogStatus.initial: 'initial',
  BlogStatus.loading: 'loading',
  BlogStatus.success: 'success',
  BlogStatus.failure: 'failure',
};
