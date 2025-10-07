import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int id;
  final String title;
  final String fullAddress;
  final double lat;
  final double lng;
  final bool isDefault;

  const Address({
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      title: json['title'] as String,
      fullAddress: json['fullAddress'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      isDefault: json['isDefault'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "fullAddress": fullAddress,
      "lat": lat,
      "lng": lng,
      "isDefault": isDefault,
    };
  }

  @override
  List<Object?> get props => [id, title, fullAddress, lat, lng, isDefault];
}
