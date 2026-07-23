import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/api_service.dart';
import 'data/product_repository.dart';
import 'providers/product_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart';
import 'ui/theme/app_theme.dart';
import 'ui/screens/product_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  final apiService = ApiService();
  final repository = ProductRepository(apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider(repository)),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const ProductListScreen(),
    );
  }
}
