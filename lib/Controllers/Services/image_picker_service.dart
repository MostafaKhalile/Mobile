import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File> imgFromCamera() async {
    final XFile image = await (_picker.pickImage(
        source: ImageSource.camera, imageQuality: 50) as FutureOr<XFile>);
    return File(image.path);
  }

  Future<File> imgFromGallery() async {
    final XFile image = await (_picker.pickImage(source: ImageSource.gallery)
        as FutureOr<XFile>);
    return File(image.path);
  }
}
