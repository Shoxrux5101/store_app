class MyDetail {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String birthDate;

  MyDetail({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  });

  factory MyDetail.fromJson(Map<String, dynamic> json) {
    return MyDetail(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      birthDate: json['birthDate'],
    );
  }
}
