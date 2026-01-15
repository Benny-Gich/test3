import 'dart:io';
import 'dart:developer' as developer;
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
      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw ServerException('No User');
      }

      final blogData = await supabaseClient
          .from('blogs')
          .insert(
            blog.toJson(),
          )
          .select('*, profiles (name)');
      final firstData = blogData.first;
      return BlogModel.fromJson(
        firstData,
      ).copyWith(posterName: firstData['profiles']['name']);
    } catch (e, s) {
      developer.log('uploadBlogError', error: e, stackTrace: s);
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
        developer.log('Blog is null');
        throw ServerException('Blog model is required for image upload');
      }
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e, s) {
      developer.log('uploadBlogImage', error: e, stackTrace: s);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles (name)');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(
              blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
