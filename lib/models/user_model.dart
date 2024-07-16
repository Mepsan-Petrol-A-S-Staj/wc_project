class User {
  final int userId;
  final String name, surname, username, password;
  final bool isAdmin;

  User({
    required this.userId,
    required this.name,
    required this.surname,
    required this.username,
    required this.password,
    required this.isAdmin,
  });

  factory User.fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Json data is null');
    }
    return User(
      userId: json['id'] ?? 0,
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'isAdmin': isAdmin,
    };
  }
}
