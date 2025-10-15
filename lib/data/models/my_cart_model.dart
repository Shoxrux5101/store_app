import 'package:equatable/equatable.dart';

class MyCartItemModel extends Equatable {
  final List<MyCartProductItem> items;
  final double subTotal;
  final double vat;
  final double shippingFee;
  final double total;

  const MyCartItemModel({
    required this.items,
    required this.subTotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
  });

  factory MyCartItemModel.fromJson(Map<String, dynamic> json) {
    return MyCartItemModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => MyCartProductItem.fromJson(e))
          .toList(),
      subTotal: (json['subTotal'] as num).toDouble(),
      vat: (json['vat'] as num).toDouble(),
      shippingFee: (json['shippingFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'subTotal': subTotal,
      'vat': vat,
      'shippingFee': shippingFee,
      'total': total,
    };
  }

  MyCartItemModel copyWith({
    List<MyCartProductItem>? items,
    double? subTotal,
    double? vat,
    double? shippingFee,
    double? total,
  }) {
    return MyCartItemModel(
      items: items ?? this.items,
      subTotal: subTotal ?? this.subTotal,
      vat: vat ?? this.vat,
      shippingFee: shippingFee ?? this.shippingFee,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [items, subTotal, vat, shippingFee, total];
}

class MyCartProductItem extends Equatable {
  final int id;
  final int productId;
  final String title;
  final String size;
  final double price;
  final String image;
  final int quantity;

  const MyCartProductItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.size,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory MyCartProductItem.fromJson(Map<String, dynamic> json) {
    return MyCartProductItem(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      size: json['size'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'size': size,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  MyCartProductItem copyWith({
    int? id,
    int? productId,
    String? title,
    String? size,
    double? price,
    String? image,
    int? quantity,
  }) {
    return MyCartProductItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      size: size ?? this.size,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props =>
      [id, productId, title, size, price, image, quantity];
}
