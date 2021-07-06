import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';

class BranchCard extends StatelessWidget {
  final String title;
  final String address;
  final String image;
  final double rating;
  final VoidCallback onPressed;
  final bool isSelectable;
  final bool isSelected;

  const BranchCard({
    Key key,
    this.title,
    this.address,
    this.image,
    this.rating,
    this.onPressed,
    @required this.isSelectable,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    // Size _size = MediaQuery.of(context).size;
    // AppLocalizations _translator = AppLocalizations.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(defaultPadding)),
      child: Card(
        margin: const EdgeInsets.only(bottom: defaultPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
              color: isSelected ?? false
                  ? AppColors.primaryColor
                  : Colors.transparent,
              width: 2.0),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(image)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        )),
                  )),
              Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: _theme.textTheme.subtitle1,
                        ),
                        Row(
                          children: [
                            Text(
                              address,
                              style: _theme.textTheme.subtitle2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
