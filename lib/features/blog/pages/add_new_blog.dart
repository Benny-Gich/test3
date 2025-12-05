// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:test3/core/theme/app_pallete.dart';
import 'package:test3/features/blog/widgets/blog_editor.dart';
import '../../../core/utils/upload_image.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});
  static String route = 'AddNewBlogRoute';
  static String path = '/add';

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final titleEditingController = TextEditingController();
  final contentEditingController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  // Initialize Upload
  void selectedImage() async {
    final pickedImage = await uploadImage();
    if (uploadImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleEditingController.dispose();
    contentEditingController.dispose();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectedImage,
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: selectedImage,
                      child: DottedBorder(
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
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopics.contains(e)
                                      ? WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              SizedBox(height: 16),
              BlogEditor(
                controller: titleEditingController,
                hintText: 'Blog Title',
              ),
              SizedBox(height: 16),
              BlogEditor(
                controller: contentEditingController,
                hintText: 'Blog Content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
