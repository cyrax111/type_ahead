import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_repository.dart';

class TypeAheadRepositoryMock implements TypeAheadRepository {
  static final event1 = EventModel(
    id: '1',
    title: 'title',
    venue: 'venue',
    date: DateTime(2000),
    image: '',
  );
  static final event2 = EventModel(
      id: '2',
      title: 'title2',
      venue: 'venue2',
      date: DateTime(2002),
      image: '');

  @override
  Future<List<EventModel>> fetchEvents(
      {required int page, required int perPage, required String query}) async {
    return [event1, event2];
  }

  @override
  Future<Favorites> restoreFavorites() async {
    return <String>{'2'};
  }

  @override
  Future<void> storeFavorites(Favorites favorites) async {}
}
