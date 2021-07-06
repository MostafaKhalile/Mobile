import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File> imgFromCamera() async {
    final PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    return File(image.path);
  }

  Future<File> imgFromGallery() async {
    final PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    return File(image.path);
  }
}
