class ApiRoutesResources {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String products = '$baseUrl/products';
  static String productDetails(int id) => '$baseUrl/products/$id';
}
