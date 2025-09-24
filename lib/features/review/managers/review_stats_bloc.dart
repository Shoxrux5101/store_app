import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/review_stats_repository.dart';
import 'review_stats_event.dart';
import 'review_stats_state.dart';

class ReviewStatsBloc extends Bloc<ReviewStatsEvent, ReviewStatsState> {
  final ReviewStatsRepository repository;

  ReviewStatsBloc(this.repository) : super(ReviewStatsInitial()) {
    on<FetchReviewStats>((event, emit) async {
      emit(ReviewStatsLoading());
      final result = await repository.fetchReviewStats(event.productId);
      result.fold(
            (error) => emit(ReviewStatsError(error.toString())),
            (stats) => emit(ReviewStatsLoaded(stats)),
      );
    });
  }
}
