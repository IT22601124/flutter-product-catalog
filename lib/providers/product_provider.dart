import 'package:flutter/material.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider(this._repository);

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  ProductStatus _status = ProductStatus.initial;
  String _errorMessage = '';
  String _searchQuery = '';

  List<Product> get products => _filteredProducts;
  ProductStatus get status => _status;
  String get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _status = ProductStatus.loading;
    notifyListeners();

    try {
      _products = await _repository.getProducts();
      _applySearch();
      _status = ProductStatus.loaded;
    } catch (e) {
      _status = ProductStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void searchProducts(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((p) => p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }
}
