class ProductModel {
  final int id;
  final int categoryId;
  final String image;
  final String title;
  final double price;
  final bool isLiked;
  final int discount;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.title,
    required this.price,
    required this.isLiked,
    required this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isLiked: json['isLiked'] ?? false,
      discount: json['discount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'image': image,
      'title': title,
      'price': price,
      'isLiked': isLiked,
      'discount': discount,
    };
  }

  ProductModel copyWith({
    int? id,
    int? categoryId,
    String? image,
    String? title,
    double? price,
    bool? isLiked,
    int? discount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      isLiked: isLiked ?? this.isLiked,
      discount: discount ?? this.discount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.image == image &&
        other.title == title &&
        other.price == price &&
        other.isLiked == isLiked &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    categoryId.hashCode ^
    image.hashCode ^
    title.hashCode ^
    price.hashCode ^
    isLiked.hashCode ^
    discount.hashCode;
  }
}