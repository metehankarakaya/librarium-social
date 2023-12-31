import 'dart:convert';
import 'dart:typed_data';

import 'package:librarium/model/user.dart';

class Post {

  Post({
    this.id,
    this.tempId,
    this.title,
    this.content,
    this.image,
    this.user,
    this.createdDate,
  });

  String? id;
  String? tempId;
  String? title;
  String? content;
  Uint8List? image;
  User? user;
  DateTime? createdDate;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    tempId: json["tempId"],
    title: json["title"],
    content: json["content"],
    image: json["image"] == null ? null : base64.decode(json["image"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tempId": tempId,
    "title": title,
    "content": content,
    "image": image != null ? base64Encode(image!) : null,
    "user": user?.toJson(),
    "createdDate": createdDate?.toIso8601String(),
  };

}