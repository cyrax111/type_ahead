import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/core/ext.dart';

import 'package:type_ahead/generated/locale_keys.g.dart';

import 'type_ahead_bloc.dart';
import 'type_ahead_model.dart';

class TypeAheadPageScreen extends StatelessWidget {
  const TypeAheadPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            TypeAheadInput(),
            SuggestionList(),
          ],
        ),
      ),
    );
  }
}

class TypeAheadInput extends StatelessWidget {
  const TypeAheadInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TypeAheadBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'state.fromTitle.tr()',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => bloc.add(TypeAheadInputChangedEvent(value)),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: Text('Cancel')),
        ],
      ),
    );
  }
}

class SuggestionList extends StatefulWidget {
  const SuggestionList({Key? key}) : super(key: key);

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final bloc = BlocProvider.of<TypeAheadBloc>(context);
      bloc.add(const BottomListReachedEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TypeAheadBloc>(context);
    return Expanded(
      child: BlocBuilder<TypeAheadBloc, TypeAheadState>(
        bloc: bloc,
        buildWhen: (previous, current) =>
            previous.events != current.events ||
            previous.favorites != current.favorites,
        builder: (context, state) {
          if (state.events.isEmpty) {
            return Center(
                child:
                    Text(LocaleKeys.type_ahead_suggestion_list_no_events.tr()));
          }
          final events = state.events;
          final lastIndex = bloc.eventsPerPage;
          return ListView.builder(
            itemCount:
                state.allEventsLoaded ? events.length : events.length + 1,
            itemBuilder: (context, index) {
              final isBottomListReached = index >= events.length;
              if (isBottomListReached) {
                return const LoadingEvents();
              }

              final event = events[index];
              final isFavorite = state.isFavorite(event.id);
              return Column(
                children: [
                  EventWidget(
                    event: state.events[index],
                    isFavorite: isFavorite,
                  ),
                  const Divider(),
                ],
              );
            },
            controller: _scrollController,
          );
        },
      ),
    );
  }
}

class LoadingEvents extends StatelessWidget {
  const LoadingEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key? key,
    required this.event,
    required this.isFavorite,
  }) : super(key: key);

  final EventModel event;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TypeAheadBloc>(context);

    return ListTile(
      onTap: () => bloc.add(EventTappedEvent(event)),
      minLeadingWidth: 80,
      leading: EventImage(image: event.image),
      title: Text(event.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.venue, maxLines: 1),
          Text(event.date.toStr, maxLines: 1),
        ],
      ),
      trailing: Text(isFavorite.toString()),
    );
  }
}

class EventImage extends StatelessWidget {
  const EventImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return const FlutterLogo();
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ));
  }
}
