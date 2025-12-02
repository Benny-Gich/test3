import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final titleEditingController = TextEditingController();
  final contentEditingController = TextEditingController();
  List<String> selectedTopics = [];
  // Initialize Upload
  Future<void> uploadBlog() async {
    final ImagePicker imagePicker = ImagePicker();
    //Take A Photo
    //final photo = await imagePicker.pickImage(source: ImageSource.camera);
    //Attach photo from Gallery
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
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
                  child: GestureDetector(
                    onTap: () {
                      uploadBlog();
                    },
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
                                  setState(() {
                                    print(selectedTopics);
                                  });
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
