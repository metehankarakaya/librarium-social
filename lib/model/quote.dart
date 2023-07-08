import 'package:librarium/model/user.dart';

class Quote {

  Quote({
    this.id,
    this.content,
    this.user,
    this.likeCount,
    this.dislikeCount,
    this.createdDate,
    this.pageNumber
  });

  String? id;
  String? content;
  User? user;
  int? likeCount;
  int? dislikeCount;
  DateTime? createdDate;
  int? pageNumber;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    id: json["id"],
    content: json["content"],
    user: json["User"] == null ? null : User.fromJson(json["User"]),
    likeCount: json["likeCount"],
    dislikeCount: json["dislikeCount"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "User": user?.toJson(),
    "likeCount": likeCount,
    "dislikeCount": dislikeCount,
    "createdDate": createdDate?.toIso8601String(),
    "pageNumber": pageNumber,
  };

}
