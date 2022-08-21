import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';

abstract class FavoriteProvider {
  Future<Favorites> restoreFavorites();
  Future<void> storeFavorites(Favorites favorites);
}

class HiveFavoriteProvider implements FavoriteProvider {
  HiveFavoriteProvider({
    required HiveInterface hive,
  }) : _hive = hive;
  final HiveInterface _hive;
  late final Box<String> _box;

  static const String _favoriteKey = 'favoriteKey';

  Future<void> init() async {
    await _hive.initFlutter();
    _box = await _hive.openBox('favoriteBox');
  }

  @override
  Future<Favorites> restoreFavorites() async {
    final value = _box.get(_favoriteKey);
    if (value == null) {
      return <String>{};
    }
    final list = jsonDecode(value);
    if (list is List) {
      return list.map((e) => e.toString()).toSet();
    }
    return <String>{};
  }

  @override
  Future<void> storeFavorites(Favorites favorites) async {
    final encoded = jsonEncode(favorites.toList());
    await _box.put(_favoriteKey, encoded);
  }
}
