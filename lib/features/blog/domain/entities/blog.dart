// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: non_constant_identifier_names

class Blog {
  final String id;
  final DateTime updatedAt;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;

  Blog({
    required this.id,
    required this.updatedAt,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
  });

  
}
