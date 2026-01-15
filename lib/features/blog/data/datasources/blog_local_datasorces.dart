import 'package:test3/features/blog/data/models/blog_model.dart';

abstract class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}
