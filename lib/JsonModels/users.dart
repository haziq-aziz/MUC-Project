class Users {
  final int? userid;
  final String username;
  final String password;

  Users({
    this.userid,
    required this.username,
    required this.password,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
      userid: json["userid"],
      username: json["username"],
      password: json["password"]);

  Map<String, dynamic> toMap() => {
        "userid": userid,
        "username": username,
        "password": password
  };
}
