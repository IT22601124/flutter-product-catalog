import '../models/product.dart';
import 'api_service.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> getProducts() async {
    try {
      return await _apiService.fetchProducts();
    } catch (e) {
      rethrow;
    }
  }
}
