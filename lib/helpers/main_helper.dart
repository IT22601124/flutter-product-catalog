import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../httpClient/dio_client.dart';
import '../repositories/api_service.dart';
import '../repositories/product_repository.dart';
import '../providers/product_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/theme_provider.dart';

class MainHelper {
  static List<ChangeNotifierProvider> getProviders() {
    final dioClient = DioClient();
    final apiService = ApiService(dioClient);
    final repository = ProductRepository(apiService);

    return [
      ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider(repository)),
      ChangeNotifierProvider<FavoriteProvider>(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
    ];
  }

  static void initializeApp() {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
