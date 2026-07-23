import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import '../constants/app_constants.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
