// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String id;
  final DateTime? updatedAt;
  final String? posterId;
  final String? title;
  final String? posterName;
  final String? content;
  final String? imageUrl;
  final List<String> topics;

  ///Offline fields
  final String? offlineId;
  final String? offlineImagePath;

  const Blog({
    required this.id,
    required this.updatedAt,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.topics = const [],
    this.posterName,
    this.offlineId,
    this.offlineImagePath,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as String,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      posterId: json['posterId'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      topics: json['topics'] != null
          ? List<String>.from(json['topics'] as List)
          : const [],
      posterName: json['posterName'] as String?,
      offlineId: json['offlineId'] as String?,
      offlineImagePath: json['offlineImagePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updatedAt': updatedAt?.toIso8601String(),
      'posterId': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'posterName': posterName,
      'offlineId': offlineId,
      'offlineImagePath': offlineImagePath,
    };
  }

  @override
  List<Object?> get props => [
    id,
    updatedAt,
    posterId,
    title,
    content,
    imageUrl,
    topics,
    posterName,
    offlineId,
    offlineImagePath,
  ];
}

extension BlogX on Blog {}
