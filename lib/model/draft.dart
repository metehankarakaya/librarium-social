import 'package:librarium/model/post.dart';
import 'package:librarium/model/quote.dart';

class Draft {

  Draft({
    this.id,
    this.userId,
    this.quotes,
    this.posts,
    this.capacity,
    this.isUpgraded,
    this.upgradedDate,
    this.createdDate
  });

  String? id;
  String? userId;
  List<Quote>? quotes;
  List<Post>? posts;
  int? capacity;
  bool? isUpgraded;
  DateTime? upgradedDate;
  DateTime? createdDate;

  factory Draft.fromJson(Map<String, dynamic> json) => Draft(
    id: json["id"],
    userId: json["userId"],
    quotes: json["quotes"] == null ? [] : List<Quote>.from(json["quotes"]!.map((x) => Quote.fromJson(x))),
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    capacity: json["capacity"],
    isUpgraded: json["isUpgraded"],
    upgradedDate: json["upgradedDate"] == null ? null : DateTime.parse(json["upgradedDate"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "user": userId,
    "quotes": quotes == null ? [] : List<Quote>.from(quotes!.map((x) => x)),
    "posts": posts == null ? [] : List<Post>.from(posts!.map((x) => x)),
    "capacity": capacity,
    "isUpgraded": isUpgraded,
    "upgradedDate": upgradedDate?.toIso8601String(),
    "createdDate": createdDate?.toIso8601String(),
  };

}
