import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test3/features/blog/data/datasources/blog_remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../models/blog_model.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(
            blog.toJson(),
          )
          .select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    BlogModel? blog,
  }) async {
    try {
      if (blog == null) {
        throw ServerException('Blog model is required for image upload');
      }
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
