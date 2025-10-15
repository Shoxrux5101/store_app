class StarModel {
  final int id;
  final int productId;
  final int rating;
  final String comment;
  final DateTime created;
  final String userFullName;

  const StarModel({
    required this.id,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.created,
    required this.userFullName,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'productId': productId,
    'rating': rating,
    'comment': comment,
    'created': created.toIso8601String(),
    'userFullName': userFullName,
  };

  factory StarModel.fromJson(Map<String, dynamic> json) => StarModel(
    id: json['id'] as int,
    productId: json['productId'] != null ? json['productId'] as int : 0,
    rating: json['rating'] as int,
    comment: json['comment'] as String,
    created: DateTime.parse(json['created'] as String),
    userFullName: json['userFullName'] as String,
  );
}