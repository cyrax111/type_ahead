import 'package:get_it/get_it.dart';
import 'package:type_ahead/di.dart';
import 'package:type_ahead/providers/api_provider.dart';
import 'package:type_ahead/providers/favorite_provider.dart';

import 'api_provider_mock.dart';
import 'favorite_provider.dart';

class ProviderDIMock implements ServiceDi {
  @override
  Future<void> create(GetIt container) async {
    container
      ..registerSingletonAsync<FavoriteProvider>(() async {
        return FavoriteProviderMock();
      })
      ..registerSingletonAsync<ApiProvider>(() async {
        return ApiProviderMock();
      });
  }
}
