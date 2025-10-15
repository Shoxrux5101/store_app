
class SortModel {
  final int id;
  final String title;
  final double price;
  final int categoryId;
  final int? sizeId;
  final String imageUrl;
  final bool isLiked;
  final double discount;

  SortModel({
    required this.id,
    required this.title,
    required this.price,
    required this.categoryId,
    this.sizeId,
    required this.imageUrl,
    required this.isLiked,
    required this.discount,
  });

  factory SortModel.fromJson(Map<String, dynamic> json) {
    try {
      return SortModel(
        id: json['id'] as int? ?? 0,
        title: json['title'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        categoryId: json['categoryId'] as int? ?? 0,
        sizeId: json['sizeId'] as int?,
        imageUrl: json['image'] as String? ?? '',
        isLiked: json['isLiked'] as bool? ?? false,
        discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e, stackTrace) {
      print('sortModel.fromJson Error: $e');
      print('jSON: $json');
      print('stack: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'categoryId': categoryId,
      'sizeId': sizeId,
      'image': imageUrl,
      'isLiked': isLiked,
      'discount': discount,
    };
  }

  @override
  String toString() {
    return 'SortModel(id: $id, title: $title, price: \$$price, categoryId: $categoryId, sizeId: $sizeId, isLiked: $isLiked, discount: $discount)';
  }
}