class UserModel {
  final String fullName;
  final String email;
  final String password;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory UserModel.toJson(Map<String, dynamic> json) => UserModel(
    fullName: json['fullName'] as String? ?? '',
    email: json['email'] as String? ?? '',
    password: json['password'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
  };
}
