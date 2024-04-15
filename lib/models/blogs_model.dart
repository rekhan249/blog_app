// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class Blogs {
  final String title;
  final String desc;
  final String dateTime;
  final Uint8List image;

  Blogs(
      {required this.title,
      required this.desc,
      required this.dateTime,
      required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'desc': desc,
      'dateTime': dateTime,
      'image': image,
    };
  }

  factory Blogs.fromMap(Map<String, dynamic> map) {
    return Blogs(
      title: map['title'] as String,
      desc: map['desc'] as String,
      dateTime: map['dateTime'] ?? DateTime.now().toIso8601String(),
      image: Uint8List.fromList(map['image']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Blogs.fromJson(String source) =>
      Blogs.fromMap(json.decode(source) as Map<String, dynamic>);
}
