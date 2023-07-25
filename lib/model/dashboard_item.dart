import 'package:librarium/model/post.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/model/user.dart';

class DashboardItem {

  DashboardItem({
    this.type,
    this.quote,
    this.post,
    this.user,
    this.createdDate,
  });

  String? type;
  Quote? quote;
  Post? post;
  User? user;
  DateTime? createdDate;

  factory DashboardItem.fromJson(Map<String, dynamic> json) => DashboardItem(
    type: json["type"],
    quote: json["quote"] == null ? null : Quote.fromJson(json["quote"]),
    post: json["post"] == null ? null : Post.fromJson(json["post"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "quote": quote?.toJson(),
    "post": post?.toJson(),
    "user": user?.toJson(),
    "createdDate": createdDate?.toIso8601String(),
  };

}