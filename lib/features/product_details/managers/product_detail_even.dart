abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final int id;
  LoadProductDetail(this.id);
}

class LoadProductDetailReviews extends ProductDetailEvent {
  final int productId;
  LoadProductDetailReviews(this.productId);
}
