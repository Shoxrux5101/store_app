import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int? id;
  final String nickname;
  final String fullAddress;
  final double lat;
  final double lng;
  final bool isDefault;

  const Address({
    this.id,
    required this.nickname,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      nickname: json['nickname'] ?? "",
      fullAddress: json['fullAddress'] ?? "",
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nickname": nickname,
      "fullAddress": fullAddress,
      "lat": lat,
      "lng": lng,
      "isDefault": isDefault,
    };
  }

  @override
  List<Object?> get props => [id, nickname, fullAddress, lat, lng, isDefault];
}