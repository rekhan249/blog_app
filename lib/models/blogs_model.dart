import 'dart:typed_data';

class Blogs {
  final String title;
  final String desc;
  final String dateTime;
  final Uint8List image;
  bool isSelected;

  Blogs(
      {required this.title,
      required this.desc,
      required this.dateTime,
      required this.image,
      required this.isSelected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'desc': desc,
      'dateTime': dateTime,
      'image': image,
      'isSelected': isSelected ? 0 : 1,
    };
  }

  factory Blogs.fromMap(Map<String, dynamic> map) => Blogs(
      title: map["title"],
      desc: map["desc"],
      dateTime: map['dateTime'] ?? DateTime.now().toIso8601String(),
      image: Uint8List.fromList(map['image']),
      isSelected: map["isSelected"] == 0 ? false : true);
}
