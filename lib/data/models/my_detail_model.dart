class MyDetailModel{
  final int id;
  final String title;
  final double price;
  final String image;

  MyDetailModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory MyDetailModel.fromJson(Map<String, dynamic> json) {
    return MyDetailModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
}
