import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_bloc.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';

import '../../mock/events_mock.dart';
import '../../mock/navigation_mock.dart';
import 'mock/type_ahead_repository_mock.dart';

void main() {
  group('TypeAheadBloc -', () {
    blocTest<TypeAheadBloc, TypeAheadState>(
      'Initialized',
      build: () => TypeAheadBloc(
          navigation: NavigationMock(),
          typeAheadRepository: TypeAheadRepositoryMock()),
      act: (bloc) => bloc.add(const InitializedEvent()),
      expect: () => [
        TypeAheadState(favorites: const {'2'}),
      ],
    );

    blocTest<TypeAheadBloc, TypeAheadState>(
      'Type "event"',
      build: () => TypeAheadBloc(
          navigation: NavigationMock(),
          typeAheadRepository: TypeAheadRepositoryMock()),
      act: (bloc) => bloc
        ..add(const InitializedEvent())
        ..add(const TypeAheadInputChangedEvent('event')),
      expect: () => [
        TypeAheadState(favorites: const {'2'}),
        TypeAheadState(favorites: const {'2'}, isLoading: true),
        TypeAheadState(
          favorites: const {'2'},
          events: [mockEvent1, mockEvent2],
          typeAheadInput: const TypeAheadInput.dirty(value: 'event'),
          allEventsLoaded: true,
        ),
      ],
    );

    blocTest<TypeAheadBloc, TypeAheadState>(
      'Type "event" and select second event',
      build: () => TypeAheadBloc(
          navigation: NavigationMock(),
          typeAheadRepository: TypeAheadRepositoryMock()),
      act: (bloc) async {
        bloc
          ..add(const InitializedEvent())
          ..add(const TypeAheadInputChangedEvent('event'));
        await Future.delayed(const Duration(seconds: 1));
        bloc.add(EventTappedEvent(mockEvent2));
      },
      expect: () => [
        TypeAheadState(favorites: const {'2'}),
        TypeAheadState(favorites: const {'2'}, isLoading: true),
        TypeAheadState(
          favorites: const {'2'},
          events: [mockEvent1, mockEvent2],
          typeAheadInput: const TypeAheadInput.dirty(value: 'event'),
          allEventsLoaded: true,
        ),
        TypeAheadState(
          favorites: const {'2'},
          events: [mockEvent1, mockEvent2],
          typeAheadInput: const TypeAheadInput.dirty(value: 'event'),
          allEventsLoaded: true,
          selectedEvent: mockEvent2,
        ),
      ],
    );

    // TODO(any): add bloc tests for another user cases
  });
}
