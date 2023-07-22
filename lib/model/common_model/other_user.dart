import 'dart:convert';
import 'dart:typed_data';

class OtherUser {

  OtherUser({
    this.id,
    this.visitorId,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.aboutMe,
    this.avatar,
    this.followings,
    this.followers,
    this.favorites,
    this.addedBooks,
    this.quotes,
    this.createdDate,
    this.blockReason,
    this.isBlocked
  });

  String? id;
  String? visitorId;
  String? username;
  String? firstName;
  String? lastName;
  String? gender;
  String? aboutMe;
  Uint8List? avatar; //byte[]
  List<String>? followings; //user Id list
  List<String>? followers; //user Id list
  List<String>? favorites; //book Id list
  List<String>? addedBooks; //book Id list
  List<String>? quotes; //quote Id list
  DateTime? createdDate;
  double? wallet;
  String? blockReason;
  bool? isBlocked;

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: json["id"],
    visitorId: json["visitorId"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    aboutMe: json["aboutMe"],
    avatar: base64.decode(json["avatar"]),
    followings: json["followings"] == null ? [] : List<String>.from(json["followings"]!.map((x) => x)),
    followers: json["followers"] == null ? [] : List<String>.from(json["followers"]!.map((x) => x)),
    favorites: json["favorites"] == null ? [] : List<String>.from(json["favorites"]!.map((x) => x)),
    addedBooks: json["addedBooks"] == null ? [] : List<String>.from(json["addedBooks"]!.map((x) => x)),
    quotes: json["quotes"] == null ? [] : List<String>.from(json["quotes"]!.map((x) => x)),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    blockReason: json["blockReason"],
    isBlocked: json["isBlocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visitorId": visitorId,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "aboutMe": aboutMe,
    "avatar": avatar != null ? base64Encode(avatar!) : null,
    "followings": followings == null ? [] : List<dynamic>.from(followings!.map((x) => x)),
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x)),
    "addedBooks": addedBooks == null ? [] : List<dynamic>.from(addedBooks!.map((x) => x)),
    "quotes": quotes == null ? [] : List<dynamic>.from(quotes!.map((x) => x)),
    "createdDate": createdDate?.toIso8601String(),
    "wallet": wallet,
    "isBlocked": isBlocked,
    "blockReason": blockReason,
  };

}
