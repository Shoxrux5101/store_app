import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/product_model.dart';

class SavedItem extends Equatable {
  final int id;
  final int categoryId;
  final String title;
  final String image;
  final double price;
  final bool isLiked;
  final int discount;

  const SavedItem({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image,
    required this.price,
    required this.isLiked,
    required this.discount,
  });

  SavedItem copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? image,
    double? price,
    bool? isLiked,
    int? discount,
  }) {
    return SavedItem(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      isLiked: isLiked ?? this.isLiked,
      discount: discount ?? this.discount,
    );
  }

  factory SavedItem.fromJson(Map<String, dynamic> json) {
    return SavedItem(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      isLiked: json['isLiked'] as bool,
      discount: json['discount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'image': image,
      'price': price,
      'isLiked': isLiked,
      'discount': discount,
    };
  }

  @override
  List<Object?> get props => [id, categoryId, title, image, price, isLiked, discount];
}
extension SavedItemMapper on SavedItem {
  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      categoryId: categoryId,
      title: title,
      image: image,
      price: price,
      isLiked: isLiked,
      discount: discount,
    );
  }
}
