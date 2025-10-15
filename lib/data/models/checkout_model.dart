class OrderModel {
  final int? id;
  final String? status;
  final double subtotal;
  final double vat;
  final double shippingFee;
  final double total;
  final int addressId;
  final int? cardId;
  final String? paymentMethod;
  final String? promoCode;

  OrderModel({
    this.id,
    this.status,
    required this.subtotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
    required this.addressId,
    this.cardId,
    this.paymentMethod,
    this.promoCode,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int?,
      status: json['status'] as String?,
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      vat: (json['vat'] ?? 0).toDouble(),
      shippingFee: (json['shippingFee'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      addressId: json['addressId'] as int,
      cardId: json['cardId'] as int?,
      paymentMethod: json['paymentMethod'] as String?,
      promoCode: json['promoCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'subtotal': subtotal,
      'vat': vat,
      'shippingFee': shippingFee,
      'total': total,
      'addressId': addressId,
      'cardId': cardId,
      'paymentMethod': paymentMethod,
      'promoCode': promoCode,
    };
  }
}

class PromoCodeModel {
  final String code;
  final double discount;
  final String type;

  PromoCodeModel({
    required this.code,
    required this.discount,
    required this.type,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      code: json['code'] as String,
      discount: (json['discount'] ?? 0).toDouble(),
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount': discount,
      'type': type,
    };
  }
}