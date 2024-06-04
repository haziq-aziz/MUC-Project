class Users {
  final String? name;
  final String? email;
  final int? phone;
  final String username;
  final String password;

  Users({
    this.name,
    this.email,
    this.phone,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
    };
  }
}
