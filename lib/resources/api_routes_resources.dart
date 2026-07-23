import '../constants/app_constants.dart';

class ApiRoutesResources {
  static const String products = '${AppConstants.baseUrl}/products';
  static String productDetails(int id) => '${AppConstants.baseUrl}/products/$id';
}
