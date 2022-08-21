import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    Key? key,
    required this.isFavorite,
    this.showNotFavorite = true,
    this.color = Colors.red,
  }) : super(key: key);

  final bool isFavorite;
  final bool showNotFavorite;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (showNotFavorite) {
      return Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: color,
      );
    }
    if (isFavorite) {
      return Icon(Icons.favorite, color: color);
    }
    return const SizedBox.shrink();
  }
}
