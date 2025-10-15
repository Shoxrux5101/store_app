import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/my_order/managers/reviews_event.dart';
import 'package:store_app/features/my_order/managers/reviews_state.dart' hide ReviewError;
import '../../../data/repository/reviews_repository.dart';
import '../../review/managers/review_state.dart' hide ReviewInitial, ReviewLoading;


class ReviewsBloc extends Bloc<RewesEvent, RewesState> {
  final ReviewsRepository repository;

  ReviewsBloc(this.repository) : super(const ReviewInitial()) {
    on<SubmitReviewEvent>(_onSubmitReview);
    on<LoadProductReviewsEvent>(_onLoadReviews);
  }

  Future<void> _onSubmitReview(
      SubmitReviewEvent event,
      Emitter<RewesState> emit,
      ) async {
    emit(const ReviewSubmitting());

    final result = await repository.createReview(
      productId: event.productId,
      rating: event.rating,
      comment: event.comment,
    );

    result.fold(
          (error) => emit(ReviewError(error.toString()) as RewesState),
          (_) => emit(const ReviewSubmitted()),
    );
  }

  Future<void> _onLoadReviews(
      LoadProductReviewsEvent event,
      Emitter<RewesState> emit,
      ) async {
    emit(const ReviewLoading());

    final result = await repository.getProductReviews(event.productId);

    result.fold(
          (error) => emit(ReviewError(error.toString()) as RewesState),
          (reviews) => emit(ReviewsLoaded(reviews)),
    );
  }
}