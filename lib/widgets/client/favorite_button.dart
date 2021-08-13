import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:techtime/Helpers/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton(
      {Key? key, this.buttonSize, required this.isFavorite, this.onTap})
      : super(key: key);
  final double? buttonSize;
  final bool isFavorite;
  final Future<bool?> Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: buttonSize!,
      circleColor: const CircleColor(
          start: AppColors.primaryColor, end: AppColors.errorColor),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: AppColors.primaryColor,
        dotSecondaryColor: AppColors.errorColor,
      ),
      likeBuilder: (isFavorite) {
        return Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.primaryColor : Colors.grey,
          size: buttonSize,
        );
      },
      onTap: onTap as Future<bool> Function(bool)?,
      isLiked: isFavorite,
    );
  }
}
