class ReviewStatsModel {
  final int totalCount;
  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStars;

  ReviewStatsModel({
    required this.totalCount,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStars,
  });

  factory ReviewStatsModel.fromJson(Map<String, dynamic> json) {
    return ReviewStatsModel(
      totalCount: json['totalCount'] ?? 0,
      fiveStars: json['fiveStars'] ?? 0,
      fourStars: json['fourStars'] ?? 0,
      threeStars: json['threeStars'] ?? 0,
      twoStars: json['twoStars'] ?? 0,
      oneStars: json['oneStars'] ?? 0,
    );
  }
}
