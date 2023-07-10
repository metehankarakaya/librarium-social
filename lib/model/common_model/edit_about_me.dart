class EditAboutMe {

  EditAboutMe({
    this.aboutMe
  });

  String? aboutMe;

  factory EditAboutMe.fromJson(Map<String, dynamic> json) => EditAboutMe(
    aboutMe: json["aboutMe"],
  );

  Map<String, dynamic> toJson() => {
    "aboutMe": aboutMe,
  };

}
