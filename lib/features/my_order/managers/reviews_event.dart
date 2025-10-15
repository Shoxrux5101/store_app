abstract class RewesEvent {
  const RewesEvent();
}

class SubmitReviewEvent extends RewesEvent {
  final int productId;
  final int rating;
  final String comment;

  const SubmitReviewEvent({
    required this.productId,
    required this.rating,
    required this.comment,
  });
}

class LoadProductReviewsEvent extends RewesEvent {
  final int productId;

  const LoadProductReviewsEvent(this.productId);
}