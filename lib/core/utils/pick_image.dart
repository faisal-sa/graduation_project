import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? xfile = await picker.pickImage(source: ImageSource.gallery);

  if (xfile == null) return null;

  File file = File(xfile.path);
  return file;
}
