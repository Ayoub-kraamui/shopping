import 'product_details.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  @override
  Future<void> fetchProductDetails(String productId) async {}

  @override
  Future<void> addToCart(String productId, int quantity) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
