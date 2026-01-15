import 'package:hive/hive.dart';
import 'package:test3/features/blog/data/datasources/blog_local_datasorces.dart';
import 'package:test3/features/blog/data/models/blog_model.dart';

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  const BlogLocalDataSourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    final List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      final blog = box.getAt(i);
      if (blog != null) {
        blogs.add(blog as BlogModel);
      }
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (int i = 0; i < blogs.length; i++) {
      box.put(i, blogs[i]);
    }
  }
}
