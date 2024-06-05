class Users {
  final int? userid;
  final String? name;
  final String? email;
  final int? phone;
  final String username;
  final String password;

  Users({
    this.userid,
    this.name,
    this.email,
    this.phone,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      userid: map['userid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      username: map['username'] ?? '', // Providing default value,
      password: map['password'] ?? '', // Providing default value,
    );
  }
}

class AdminSession {
  static String? adminUsername;

  static void setAdminSession(String username) {
    adminUsername = username;
  }

  static bool isAdminLoggedIn() {
    return adminUsername != null;
  }

  static void clearAdminSession() {
    adminUsername = null;
  }
}

