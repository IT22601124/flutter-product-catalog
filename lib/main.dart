import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/main_helper.dart';
import 'providers/theme_provider.dart';
import 'ui/theme/app_theme.dart';
import 'utils/app_router.dart';

void main() {
  MainHelper.initializeApp();
  
  runApp(
    MultiProvider(
      providers: MainHelper.getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}
