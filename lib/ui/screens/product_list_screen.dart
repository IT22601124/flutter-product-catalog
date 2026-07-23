import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/theme_provider.dart';
import '../../resources/icon_resources.dart';
import '../../resources/dimensions.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.isDarkMode ? IconResources.lightMode : IconResources.darkMode),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeSmall,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(IconResources.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                context.read<ProductProvider>().searchProducts(value);
              },
            ),
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          switch (provider.status) {
            case ProductStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProductStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${provider.errorMessage}'),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    ElevatedButton(
                      onPressed: () => provider.loadProducts(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case ProductStatus.loaded:
              if (provider.products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              return RefreshIndicator(
                onRefresh: () => provider.loadProducts(),
                child: GridView.builder(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: Dimensions.paddingSizeDefault,
                    mainAxisSpacing: Dimensions.paddingSizeDefault,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: provider.products[index]);
                  },
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
