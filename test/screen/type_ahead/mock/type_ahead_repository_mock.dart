import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_repository.dart';

import '../../../mock/events_mock.dart';

class TypeAheadRepositoryMock implements TypeAheadRepository {
  @override
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query}) async {
    return [mockEvent1, mockEvent2];
  }

  @override
  Future<Favorites> restoreFavorites() async {
    return <String>{mockEvent2.id};
  }

  @override
  Future<void> storeFavorites(Favorites favorites) async {}
}
