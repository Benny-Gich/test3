import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:test3/core/theme/app_pallete.dart';
import 'package:test3/features/auth/presentation/widgets/auth_field.dart';
import 'package:test3/features/blog/widgets/blog_editor.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});
  static String route = 'AddNewBlogRoute';
  static String path = '/add';

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.done_all_rounded)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: AppPallete.borderColor,
                    dashPattern: [10, 4],
                    strokeCap: StrokeCap.round,
                    radius: Radius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 180,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 64,
                        ),
                        SizedBox(height: 16),
                        Text('Select your Image'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        [
                              'Technology',
                              'Business',
                              'Politics',
                              'Sports',
                            ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(
                                  label: Text(e),
                                  side: BorderSide(
                                    color: AppPallete.borderColor,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: 16),
                BlogEditor(
                  controller: TextEditingController(),
                  hintText: 'Blog Title',
                ),
                SizedBox(height: 16),
                BlogEditor(controller: TextEditingController(), hintText: 'Blog ')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
