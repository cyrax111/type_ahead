import 'package:type_ahead/providers/api_provider.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';

import 'events_mock.dart';

class ApiProviderMock implements ApiProvider {
  @override
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query}) async {
    return [mockEvent1, mockEvent2];
  }
}
