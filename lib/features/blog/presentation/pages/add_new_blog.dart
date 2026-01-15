// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:test3/core/common/widgets/utils/show_snackbar.dart';
import 'package:test3/core/theme/app_pallete.dart';
import 'package:test3/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:test3/features/blog/presentation/pages/blog_page.dart';
import 'package:test3/features/blog/presentation/widgets/blog_editor.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/upload_image.dart';

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
  final formKey = GlobalKey<FormState>();
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

  void uploadBlog() {
    if (!(formKey.currentState?.validate() ?? false)) {
      showSnackBar(context, 'Please fix the form errors');
      return;
    }
    if (selectedTopics.isEmpty) {
      showSnackBar(context, 'Please choose at least one topic.');
      return;
    }
    if (image == null) {
      showSnackBar(context, 'Please select an image for the post.');
      return;
    }
    final appUserState = context.read<AppUserCubit>().state;
    if (appUserState is! AppUserLoggedIn) {
      showSnackBar(context, 'You must be logged in to upload a blog.');
      return;
    }

    final posterId = appUserState.profile.id;

    context.read<BlogBloc>().add(
      BlogUpload(
        blogId: Uuid().v1(),
        posterId: posterId,
        title: titleEditingController.text.trim(),
        content: contentEditingController.text.trim(),
        image: image!,
        topics: selectedTopics,
      ),
    );
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
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: Icon(Icons.done_all_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BlogStatus.failure) {
            showSnackBar(context, state.error);
          } else if (state.status == BlogStatus.success) {
            context.navigateTo(NamedRoute(BlogPage.route));
            // refresh blogs in the bloc so the blog page shows the newly uploaded post
            // context.read<BlogBloc>().add(BlogGetAllBlogs());
            // context.router.replaceAll(
            //   [
            //     NamedRoute(BlogPage.route),
            //   ],
            // );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectedImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
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
        },
      ),
    );
  }
}
