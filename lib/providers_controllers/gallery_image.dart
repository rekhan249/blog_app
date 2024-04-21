import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryImageProvider with ChangeNotifier {
  Uint8List? _profile;
  get profile => _profile;

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

class SearchProvider with ChangeNotifier {
  String? _searchQuery = "";

  get searchQuery => _searchQuery;

  void searchingQuery([String? value]) {
    _searchQuery = value;
    notifyListeners();
  }
}
