import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/review_model.dart';
import 'package:store_app/data/repository/review_repository.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;

  ReviewBloc({required this.repository}) : super(ReviewInitial()) {
    on<LoadReviews>(_onLoadReviews);
  }

  Future<void> _onLoadReviews(
      LoadReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());

    try {
      final result = await repository.fetchReviews(event.productId);

      result.fold(
            (error) => emit(ReviewError(error.toString())),
            (reviews) => emit(ReviewLoaded(reviews)),
      );
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
