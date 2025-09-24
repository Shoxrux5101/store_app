abstract class ReviewEvent {}

class LoadReviews extends ReviewEvent {
  final int productId;
  LoadReviews(this.productId);
}
