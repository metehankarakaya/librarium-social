import 'dart:convert';
import 'dart:typed_data';

import 'package:librarium/model/author.dart';

class Book {

  Book({
    this.id,
    this.title,
    this.description,
    this.language,
    this.isbn,
    this.pageCount,
    this.coverImage,
    this.author,
    this.publishDate,
    this.price,
    this.rating
  });

  String? id;
  String? title;
  String? description;
  String? language;
  String? isbn;
  int? pageCount;
  Uint8List? coverImage;
  Author? author;
  DateTime? publishDate;
  double? price;
  double? rating;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    language: json["language"],
    isbn: json["isbn"],
    pageCount: json["pageCount"],
    coverImage: base64.decode(json["coverImage"]),
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    publishDate: json["publishDate"] == null ? null : DateTime.parse(json["publishDate"]),
    price: json["price"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "language": language,
    "isbn": isbn,
    "pageCount": pageCount,
    "coverImage": coverImage != null ? base64Encode(coverImage!) : null,
    "author": author?.toJson(),
    "publishDate": publishDate?.toIso8601String(),
    "price": price,
    "rating": rating,
  };

}
