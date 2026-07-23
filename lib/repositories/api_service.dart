import '../models/product.dart';
import '../httpClient/dio_client.dart';
import '../resources/api_routes_resources.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  Future<List<Product>> fetchProducts() async {
    try {
      // Use the centralized endpoint from ApiRoutesResources
      final response = await _dioClient.dio.get(ApiRoutesResources.products);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
