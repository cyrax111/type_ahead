import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:type_ahead/core/http_client_headers.dart';
import 'package:type_ahead/di.dart';
import 'package:http/http.dart' as http;

import 'api_provider.dart';
import 'favorite_provider.dart';

class ProviderDI implements ServiceDi {
  static FavoriteProvider get favorite => getIt.get<FavoriteProvider>();
  static ApiProvider get apiProvider => getIt.get<ApiProvider>();

  static http.Client get _httpClient => getIt.get<http.Client>();

  @override
  Future<void> create(GetIt container) async {
    container
      ..registerSingletonAsync<http.Client>(
        () async {
          const username = 'Mjg1NjA4MTZ8MTY2MDk4NDc5MS40MzM1ODY';
          const password =
              '0a3836d4bb5b1c85719f4bd6f2c1f91cb5649960591b399ba5a4e18eb687e473';

          final basicAuth =
              'Basic ${base64Encode(utf8.encode('$username:$password'))}';
          return HttpClientHeaders(
              defaultHeaders: <String, String>{'authorization': basicAuth});
        },
        dispose: (param) => param.close(),
      )
      ..registerSingletonAsync<FavoriteProvider>(() async {
        final storage = HiveFavoriteProvider(hive: Hive);
        await storage.init();
        return storage;
      })
      ..registerSingletonAsync<ApiProvider>(() async {
        final provider = SeatGeekApiProvider(client: _httpClient);
        return provider;
      }, dependsOn: [http.Client]);
  }
}
