import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/core/error/exception.dart';
import 'package:test3/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSources {
  Future<BlogModel> uploadBlog(BlogModel blog) async {}
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSources {
  final SupabaseClient supabaseClient;
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {} catch (e) {
      throw ServerException(e.toString());
    }
  }
}
