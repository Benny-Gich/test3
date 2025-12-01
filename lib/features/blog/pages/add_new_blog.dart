import 'package:flutter/material.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});
  static String route='AddNewBlogRoute';
  static String path='/blog/add';

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();

}

class _AddNewBlogState extends State<AddNewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Blog'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
    );
  }
}
