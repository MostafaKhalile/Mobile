import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:techtime/Helpers/colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key key, this.buttonSize, this.isFavorite, this.onTap})
      : super(key: key);
  final double buttonSize;
  final bool isFavorite;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: buttonSize,
      circleColor: CircleColor(start: KPrimaryColor, end: KErrorColor),
      bubblesColor: BubblesColor(
        dotPrimaryColor: KPrimaryColor,
        dotSecondaryColor: KErrorColor,
      ),
      likeBuilder: (isFavorite) {
        return Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? KPrimaryColor : Colors.grey,
          size: buttonSize,
        );
      },
      onTap: onTap,
      isLiked: isFavorite,
    );
  }
}
