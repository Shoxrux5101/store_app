class MyOrderModel {
  final int id;
  final String title;
  final String image;
  final String size;
  final int price;
  final String status;
  int? rating;
  final String orderNumber;
  final int productId;

  MyOrderModel({
    required this.id,
    required this.title,
    required this.image,
    required this.productId,
    required this.size,
    required this.price,
    required this.status,
    this.rating,
    required this.orderNumber,
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    int? parseRating(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      final s = value.toString();
      return int.tryParse(s);
    }

    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is double) return value.toInt();
      return int.tryParse(value.toString()) ?? 0;
    }

    return MyOrderModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      size: json['size'] as String? ?? '',
      productId: json['product_id'] as int? ?? 0,
      price: parseInt(json['price']),
      status: json['status'] as String? ?? '',
      rating: parseRating(json['rating']),
      orderNumber: (json['order_number'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': image,
    'size': size,
    'product_id': productId,
    'price': price,
    'status': status,
    'rating': rating,
    'order_number': orderNumber,
  };

  MyOrderModel copyWith({
    int? id,
    String? title,
    String? image,
    String? size,
    int? price,
    String? status,
    int? rating,
    String? orderNumber,
    int? productId,
  }) {
    return MyOrderModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      image: image ?? this.image,
      size: size ?? this.size,
      price: price ?? this.price,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      orderNumber: orderNumber ?? this.orderNumber,
    );
  }

  @override
  String toString() {
    return 'MyOrderModel(id: $id, title: $title, size: $size, price: $price, status: $status, rating: $rating, orderNumber: $orderNumber)';
  }
}
