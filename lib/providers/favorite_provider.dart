import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class FavoriteProvider with ChangeNotifier {
  Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => _favoriteIds;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedIds = prefs.getStringList(AppConstants.favoritePrefKey);
    if (storedIds != null) {
      _favoriteIds = storedIds.map((id) => int.parse(id)).toSet();
      notifyListeners();
    }
  }

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  Future<void> toggleFavorite(int productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      AppConstants.favoritePrefKey,
      _favoriteIds.map((id) => id.toString()).toList(),
    );
  }
}
