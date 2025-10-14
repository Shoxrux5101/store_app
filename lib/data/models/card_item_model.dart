// lib/features/card/models/card_model.dart

class CardModel {
  final int id;
  final String cardNumber;

  CardModel({
    required this.id,
    required this.cardNumber,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int,
      cardNumber: json['cardNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
    };
  }

  CardModel copyWith({
    int? id,
    String? cardNumber,
  }) {
    return CardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
    );
  }
}

class CardsListModel {
  final List<CardModel> cards;

  CardsListModel({required this.cards});

  factory CardsListModel.fromJson(List<dynamic> json) {
    return CardsListModel(
      cards: json.map((item) => CardModel.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return cards.map((card) => card.toJson()).toList();
  }
}