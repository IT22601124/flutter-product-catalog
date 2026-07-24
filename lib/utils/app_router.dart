import 'package:go_router/go_router.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/screens/product_list_screen.dart';
import '../ui/screens/product_detail_screen.dart';
import '../models/product.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String productDetail = '/product-detail';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: productDetail,
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductDetailScreen(product: product);
        },
      ),
    ],
  );
}
