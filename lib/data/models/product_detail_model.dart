class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final bool isLiked;
  final List<ProductDetailImageModel> productImages;
  final List<ProductDetailSizeModel> productSizes;
  final int reviewsCount;
  final double rating;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isLiked,
    required this.productImages,
    required this.productSizes,
    required this.reviewsCount,
    required this.rating,
  });

  ProductDetailModel copyWith({
    bool? isLiked,
    String? title,
    String? description,
    double? price,
    List<ProductDetailImageModel>? productImages,
    List<ProductDetailSizeModel>? productSizes,
    int? reviewsCount,
    double? rating,
  }) {
    return ProductDetailModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      isLiked: isLiked ?? this.isLiked,
      productImages: productImages ?? this.productImages,
      productSizes: productSizes ?? this.productSizes,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      rating: rating ?? this.rating,
    );
  }

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      isLiked: json['isLiked'],
      productImages: (json['productImages'] as List)
          .map((e) => ProductDetailImageModel.fromJson(e))
          .toList(),
      productSizes: (json['productSizes'] as List)
          .map((e) => ProductDetailSizeModel.fromJson(e))
          .toList(),
      reviewsCount: json['reviewsCount'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}

class ProductDetailImageModel {
  final int id;
  final String image;

  ProductDetailImageModel({required this.id, required this.image});

  factory ProductDetailImageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailImageModel(
      id: json['id'],
      image: json['image'],
    );
  }
}

class ProductDetailSizeModel {
  final int id;
  final String title;

  ProductDetailSizeModel({required this.id, required this.title});

  factory ProductDetailSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailSizeModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
