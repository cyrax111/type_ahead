// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:type_ahead/core/ext.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_bloc.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_model.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_screen.dart';

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
          return Center(child: Text('No selected event'));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(event.title, maxLines: 2),
            actions: [
              FivoriteAction(
                eventModel: event,
                isFavorite: state.isFavorite(event.id),
                callback: () => bloc.add(FavoriteTappedEvent(event)),
              )
            ],
          ),
          body: SafeArea(
            child: DetailWidget(eventModel: event),
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
  }) : super(key: key);

  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image(
          //   image: NetworkImage(eventModel.image),
          //   fit: BoxFit.fitWidth,
          // ),
          EventImage(image: eventModel.image),
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

class FivoriteAction extends StatelessWidget {
  const FivoriteAction({
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
      icon: isFavorite
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
      onPressed: callback,
      iconSize: 32,
    );
  }
}
