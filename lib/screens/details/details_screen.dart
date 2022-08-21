import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:type_ahead/core/ext.dart';
import 'package:type_ahead/generated/locale_keys.g.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_bloc.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';
import 'package:type_ahead/widgets/event_image.dart';
import 'package:type_ahead/widgets/favorite.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TypeAheadBloc>(context);

    return BlocBuilder<TypeAheadBloc, TypeAheadState>(
      bloc: bloc,
      builder: (context, state) {
        final event = state.selectedEvent;
        if (event == null) {
          return Center(child: Text(LocaleKeys.details_empty_event.tr()));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(event.title, maxLines: 2),
            actions: [
              FavoriteAction(
                eventModel: event,
                isFavorite: state.isFavorite(event.id),
                callback: () => bloc.add(FavoriteTappedEvent(event)),
              )
            ],
          ),
          body: SafeArea(
            child: DetailWidget(
                eventModel: event, isFavorite: state.isFavorite(event.id)),
          ),
        );
      },
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    required this.eventModel,
    required this.isFavorite,
  }) : super(key: key);

  final EventModel eventModel;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EventImage(image: eventModel.image, isFavorite: isFavorite),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(eventModel.date.toStr,
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          Text(eventModel.venue, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}

class FavoriteAction extends StatelessWidget {
  const FavoriteAction({
    Key? key,
    required this.eventModel,
    required this.isFavorite,
    required this.callback,
  }) : super(key: key);

  final EventModel eventModel;
  final bool isFavorite;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FavoriteWidget(isFavorite: isFavorite),
      onPressed: callback,
    );
  }
}
