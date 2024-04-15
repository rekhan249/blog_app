import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryImageProvider with ChangeNotifier {
  Uint8List? _profile;
  get profile => _profile;

  oldImage(Uint8List? oldImage) {
    _profile = oldImage;
    notifyListeners();
  }

  uploadImage() async {
    final XFile? imagePro = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imagePro != null) {
      _profile = await imagePro.readAsBytes();
    } else {
      _profile = null;
    }
    notifyListeners();
  }
}
