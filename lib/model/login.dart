class Login {

  Login({
    this.username,
    this.password
  });

  String? username;
  String? password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
      username: json["username"],
      password: json["password"]
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };

}
