import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/common/widgets/utils/loader.dart';
import 'package:test3/core/theme/app_pallete.dart';
import 'package:test3/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:test3/features/blog/presentation/pages/add_new_blog.dart';
import 'package:test3/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  static String route = 'BlogPage';
  static String path = '/blog';

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Use the route name (defined on the page) rather than the path
              // AutoRoute's NamedRoute expects the route name, not the path string
              context.router.navigate(NamedRoute(AddNewBlog.route));
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          // if (state is BlogFailure) {
          //   showSnackBar(context, state.error);
          // }
        },
        builder: (context, state) {
          if (state.status == BlogStatus.loading && state.blogs.isEmpty) {
            return Loader();
          }
          if (state.status == BlogStatus.success && state.blogs.isEmpty) {
            /// Create an empty
            return Center(
              child: Text("no blogs available"),
            );
          }

          return ListView.builder(
            itemCount: state.blogs.length,
            itemBuilder: (context, index) {
              final blog = state.blogs[index];
              return BlogCard(
                blogs: blog,
                color: index % 3 == 0
                    ? AppPallete.gradient1
                    : index % 2 == 1
                    ? AppPallete.gradient2
                    : AppPallete.gradient3,
              );
            },
          );
        },
      ),
    );
  }
}
