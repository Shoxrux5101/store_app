import 'package:equatable/equatable.dart';

sealed class ReviewStatsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FetchReviewStats extends ReviewStatsEvent {
  final int productId;

  FetchReviewStats(this.productId);

  @override
  List<Object?> get props => [productId];
}
