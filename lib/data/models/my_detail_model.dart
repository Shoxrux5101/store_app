class MyDetail {
  final int id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? gender;
  final String? birthDate;

  MyDetail({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.birthDate,
  });

  factory MyDetail.fromJson(Map<String, dynamic> json) {
    return MyDetail(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birthDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'birthDate': birthDate,
    };
  }

  MyDetail copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? gender,
    String? birthDate,
  }) {
    return MyDetail(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}