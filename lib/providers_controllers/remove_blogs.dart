import 'package:blogs_app/models/blogs_model.dart';
import 'package:flutter/material.dart';

class MultiSelectProvider with ChangeNotifier {
  final List<Blogs> _multiSelectOrRemove = [];
  get multiSelectOrRemove => _multiSelectOrRemove;
  void selectOrRemoveObjectToAndFrom(
      int index, Blogs singleBlogs, List<Blogs?> blogList) {
    blogList[index]!.isSelected = !blogList[index]!.isSelected;
    if (blogList[index]!.isSelected == true) {
      _multiSelectOrRemove.add(blogList[index]!);
      print(
          "=========================== ${_multiSelectOrRemove.map((e) => e.toMap())}");
    } else if (blogList[index]!.isSelected == false) {
      _multiSelectOrRemove.remove(blogList[index]!);
      print(
          "=========================== ${_multiSelectOrRemove.map((e) => e.toMap())}");
    }
    notifyListeners();
  }
}
