import 'package:type_ahead/providers/favorite_provider.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';

import 'events_mock.dart';

class FavoriteProviderMock implements FavoriteProvider {
  @override
  Future<Favorites> restoreFavorites() async {
    return <String>{mockEvent2.id};
  }

  @override
  Future<void> storeFavorites(Favorites favorites) async {}
}
