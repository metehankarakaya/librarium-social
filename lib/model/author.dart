import 'package:librarium/model/book.dart';

class Author {

  Author({
    this.id,
    this.firstName,
    this.lastName,
    this.nationality,
    this.age,
    this.birthDate,
    this.deathDate,
    this.books
  });

  String? id;
  String? firstName;
  String? lastName;
  String? nationality;
  int? age;
  DateTime? birthDate;
  DateTime? deathDate;
  List<Book>? books;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    nationality: json["nationality"],
    age: json["age"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    deathDate: json["deathDate"] == null ? null : DateTime.parse(json["deathDate"]),
    books: json["books"] == null ? [] : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "nationality": nationality,
    "age": age,
    "birthDate": birthDate?.toIso8601String(),
    "deathDate": deathDate?.toIso8601String(),
    "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toJson())),
  };

}
