
import '../../../data/models/review_model.dart';

abstract class RewesState {
  const RewesState();
}

class ReviewInitial extends RewesState {
  const ReviewInitial();
}

class ReviewLoading extends RewesState {
  const ReviewLoading();
}

class ReviewSubmitting extends RewesState {
  const ReviewSubmitting();
}

class ReviewSubmitted extends RewesState {
  const ReviewSubmitted();
}

class ReviewsLoaded extends RewesState {
  final List<ReviewModel> reviews;

  const ReviewsLoaded(this.reviews);
}

class ReviewError extends RewesState {
  final String message;

  const ReviewError(this.message);
}