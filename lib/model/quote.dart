import 'package:librarium/model/book.dart';
import 'package:librarium/model/user.dart';

class Quote {

  Quote({
    this.id,
    this.content,
    this.user,
    this.book,
    this.likeCount,
    this.dislikeCount,
    this.createdDate,
    this.pageNumber
  });

  String? id;
  String? content;
  User? user;
  Book? book;
  int? likeCount;
  int? dislikeCount;
  DateTime? createdDate;
  int? pageNumber;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    id: json["id"],
    content: json["content"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    book: json["book"] == null ? null : Book.fromJson(json["book"]),
    likeCount: json["likeCount"],
    dislikeCount: json["dislikeCount"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "user": user?.toJson(),
    "book": book?.toJson(),
    "likeCount": likeCount,
    "dislikeCount": dislikeCount,
    "createdDate": createdDate?.toIso8601String(),
    "pageNumber": pageNumber,
  };

}
