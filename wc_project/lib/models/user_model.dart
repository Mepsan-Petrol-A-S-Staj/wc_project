class User {
  final String name;
  final String surname;
  final String username;
  final String password;
  final bool isAdmin;

  User({
    required this.name,
    required this.surname,
    required this.username,
    required this.password,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
      password: json['password'],
      isAdmin: json['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'isAdmin': isAdmin,
    };
  }
}

