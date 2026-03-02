import '../../../../core/network/dio_client.dart';
import '../model/product_model.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DioClient _dioClient;
  List<ProductModel>? _cachedProducts;

  HomeRepositoryImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<List<ProductModel>> getProducts() async {
    if (_cachedProducts != null && _cachedProducts!.isNotEmpty) {
      return _cachedProducts!;
    }

    try {
      final response = await _dioClient.dio.get('/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _cachedProducts = data
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return _cachedProducts!;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: \${e.toString()}');
    }
  }
}
