import 'dart:typed_data';

class Blogs {
  final int? id;
  final String title;
  final String desc;
  final DateTime dateTime;
  final Uint8List image;

  Blogs(
      {required this.id,
      required this.title,
      required this.desc,
      required this.dateTime,
      required this.image});

  Blogs copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Blogs(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc,
        dateTime: DateTime.timestamp(),
        image: image,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'image': image,
    };
  }

  factory Blogs.fromMap(Map<String, dynamic> map) {
    return Blogs(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      image: Uint8List.fromList(map['image']),
    );
  }
}
