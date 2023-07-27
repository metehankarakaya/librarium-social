import 'package:librarium/model/post.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/model/user.dart';

class Draft {

  Draft({
    this.id,
    this.user,
    this.quotes,
    this.posts,
    this.capacity,
    this.isUpgraded,
    this.upgradedDate,
    this.createdDate
  });

  String? id;
  User? user;
  List<Quote>? quotes;
  List<Post>? posts;
  int? capacity;
  bool? isUpgraded;
  DateTime? upgradedDate;
  DateTime? createdDate;

  factory Draft.fromJson(Map<String, dynamic> json) => Draft(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    quotes: json["quotes"] == null ? [] : List<Quote>.from(json["quotes"]!.map((x) => x)),
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => x)),
    capacity: json["capacity"],
    isUpgraded: json["isUpgraded"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "quotes": quotes == null ? [] : List<Quote>.from(quotes!.map((x) => x)),
    "posts": posts == null ? [] : List<Post>.from(posts!.map((x) => x)),
    "capacity": capacity,
    "isUpgraded": isUpgraded,
    "createdDate": createdDate?.toIso8601String(),
  };

}
