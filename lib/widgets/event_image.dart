import 'package:flutter/material.dart';
import 'package:type_ahead/widgets/favorite.dart';

class EventImage extends StatelessWidget {
  const EventImage({
    Key? key,
    required this.image,
    required this.isFavorite,
  }) : super(key: key);

  final String image;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return const FlutterLogo();
    }
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            )),
        Positioned(
          left: 0,
          top: 0,
          child: FavoriteWidget(isFavorite: isFavorite, showNotFavorite: false),
        ),
      ],
    );
  }
}
