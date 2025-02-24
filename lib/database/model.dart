class User {
  final String name;
  final String email;
  final String phone;

  User({required this.name, required this.email, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name']['first'] + ' ' + json['name']['last'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
