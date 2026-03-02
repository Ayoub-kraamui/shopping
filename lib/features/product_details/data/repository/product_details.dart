abstract class ProductDetailsRepository {
  Future<void> fetchProductDetails(String productId);
  Future<void> addToCart(String productId, int quantity);
}
