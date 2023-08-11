class UserModel {
  String id;
  String name;
  String email;
  List<Role> roles;
  dynamic image;

  UserModel({
    this.id = "",
    this.name = "",
    this.email = "",
    this.roles = const [],
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: "${json["id"] ?? ""}",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        roles: json["roles"] != null
            ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))
            : [],
        image: json["image"],
      );
}

class Role {
  String id;
  String name;

  Role({
    this.id = "",
    this.name = "",
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: "${json["id"] ?? ""}",
        name: json["name"] ?? "",
      );
}
