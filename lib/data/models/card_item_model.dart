class CardModel {
  final int? id;
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  CardModel({
    this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int?,
      cardNumber: (json['cardNumber'] ?? '') as String,
      expiryDate: (json['expiryDate'] ?? '') as String,
      securityCode: (json['securityCode'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'securityCode': securityCode,
    };
  }

  String get cardType {
    final clean = cardNumber.replaceAll(' ', '');
    if (clean.isEmpty) return 'CARD';
    if (clean.startsWith('4')) return 'VISA';
    if (RegExp(r'^5[1-5]').hasMatch(clean)) return 'MASTERCARD';
    if (RegExp(r'^(34|37)').hasMatch(clean)) return 'AMEX';
    if (RegExp(r'^(86|60)').hasMatch(clean)) return 'UZCARD';
    return 'CARD';
  }
}
