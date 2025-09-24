class CardItemModel {
  final int id;
  final int productId;
  final String title;
  final String size;
  final double price;
  final String image;
  final int quantity;

  CardItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.size,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CardItemModel.fromJson(Map<String, dynamic> json) {
    return CardItemModel(
      id: json['id'] as int,
      productId: json['productId'] as int,
      title: json['title'] as String,
      size: json['size'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      quantity: json['quantity'] as int,
    );
  }
}

class CardModel {
  final List<CardItemModel> items;
  final double subTotal;
  final double vat;
  final double shippingFee;
  final double total;

  CardModel({
    required this.items,
    required this.subTotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      items: (json['items'] as List)
          .map((e) => CardItemModel.fromJson(e))
          .toList(),
      subTotal: (json['subTotal'] as num).toDouble(),
      vat: (json['vat'] as num).toDouble(),
      shippingFee: (json['shippingFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
}
