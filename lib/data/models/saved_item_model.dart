class SavedItem {
  final int id;
  final String title;
  final String image;
  final int price;
  final bool isLiked;

  SavedItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.isLiked,
  });

  SavedItem copyWith({
    int? id,
    String? title,
    String? image,
    int? price,
    bool? isLiked,
  }) {
    return SavedItem(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory SavedItem.fromJson(Map<String, dynamic> json) {
    return SavedItem(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'],
      isLiked: json['isLiked'],
    );
  }
}
