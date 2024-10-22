class User {
  late int id;
  late String name;
  late String username;
  late String password;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password
    };
  }
}
