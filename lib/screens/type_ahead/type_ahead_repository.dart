import 'package:type_ahead/providers/api_provider.dart';
import 'package:type_ahead/providers/favorite_provider.dart';

import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';

abstract class TypeAheadRepository {
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query});

  Future<Favorites> restoreFavorites();
  Future<void> storeFavorites(Favorites favorites);
}

class TypeAheadRepositorySimple implements TypeAheadRepository {
  TypeAheadRepositorySimple({
    required ApiProvider provider,
    required FavoriteProvider favoriteProvider,
  })  : _provider = provider,
        _favoriteProvider = favoriteProvider;
  final ApiProvider _provider;
  final FavoriteProvider _favoriteProvider;

  @override
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query}) async {
    return _provider.fetchEvents(page: page, query: query, perPage: perPage);
  }

  @override
  Future<Favorites> restoreFavorites() async {
    return await _favoriteProvider.restoreFavorites();
  }

  @override
  Future<void> storeFavorites(Favorites favorites) async {
    await _favoriteProvider.storeFavorites(favorites);
  }
}
