import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> uploadImage() async {
  final ImagePicker imagePicker = ImagePicker();
  try {
    //Take A Photo
    //final photo = await imagePicker.pickImage(source: ImageSource.camera);
    //Attach photo from Gallery
    final upload = await imagePicker.pickImage(source: ImageSource.gallery);
    if (upload != null) {
      return File(upload.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
