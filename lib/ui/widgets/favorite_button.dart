import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorite_provider.dart';
import '../../resources/icon_resources.dart';
import '../../resources/color_resources.dart';

class FavoriteButton extends StatelessWidget {
  final int productId;

  const FavoriteButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        final isFavorite = favoriteProvider.isFavorite(productId);
        return IconButton(
          icon: Icon(
            isFavorite ? IconResources.favorite : IconResources.favoriteBorder,
            color: isFavorite ? ColorResources.errorColor : null,
          ),
          onPressed: () {
            favoriteProvider.toggleFavorite(productId);
          },
        );
      },
    );
  }
}
