import 'dart:convert';
import 'dart:typed_data';

class User {

  User({
    this.id,
    this.token,
    this.username,
    this.password,
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
    this.birthDate,
    this.createdDate,
    this.wallet,
    this.blockReason,
    this.isBlocked
  });

  String? id;
  String? token;
  String? username;
  String? password;
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
  DateTime? birthDate;
  DateTime? createdDate;
  double? wallet;
  String? blockReason;
  bool? isBlocked;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    token: json["token"],
    username: json["username"],
    password: json["password"],
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
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    wallet: json["wallet"]?.toDouble(),
    blockReason: json["blockReason"],
    isBlocked: json["isBlocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "username": username,
    "password": password,
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
    "birthDate": birthDate?.toIso8601String(),
    "createdDate": createdDate?.toIso8601String(),
    "wallet": wallet,
    "isBlocked": isBlocked,
    "blockReason": blockReason,
  };

}
