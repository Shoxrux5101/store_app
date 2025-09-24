import 'package:equatable/equatable.dart';
import '../../../data/models/review_stats.dart';

sealed class ReviewStatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ReviewStatsInitial extends ReviewStatsState {}

final class ReviewStatsLoading extends ReviewStatsState {}

final class ReviewStatsLoaded extends ReviewStatsState {
  final ReviewStatsModel stats;

  ReviewStatsLoaded(this.stats);

  @override
  List<Object?> get props => [stats];
}

final class ReviewStatsError extends ReviewStatsState {
  final String message;

  ReviewStatsError(this.message);

  @override
  List<Object?> get props => [message];
}
