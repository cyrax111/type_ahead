import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:type_ahead/core/http_client_headers.dart';
import 'package:type_ahead/providers/api_provider.dart';

void main() {
  group(
    'seatgeek real request -',
    () {
      test('description', () async {
        const perPage = 20;
        const username = 'Mjg1NjA4MTZ8MTY2MDk4NDc5MS40MzM1ODY';
        const password =
            '0a3836d4bb5b1c85719f4bd6f2c1f91cb5649960591b399ba5a4e18eb687e473';

        final basicAuth =
            'Basic ${base64Encode(utf8.encode('$username:$password'))}';
        final httpClient = HttpClientHeaders(
            defaultHeaders: <String, String>{'authorization': basicAuth});
        final provider = SeatGeekApiProvider(
          client: httpClient,
        );

        await expectLater(
            provider.fetchEvents(page: 1, query: 'a', perPage: 20), completes);
      });
    },
    skip: false,
  );
}
