import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/screens/Client/branchProfile/branchProfile.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';

class BranchCard extends StatelessWidget {
  final String title;
  final String description;
  final String address;
  final String image;
  final double rating;
  final Function onPressed;
  final bool isSelectable;
  final bool isSelected;

  const BranchCard({
    Key key,
    this.title,
    this.description,
    this.address,
    this.image,
    this.rating,
    this.onPressed,
    @required this.isSelectable,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: KDefaultPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
            color: isSelected ?? false ? KPrimaryColor : Colors.transparent,
            width: 2.0),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KDefaultPadding)),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(image)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: KDefaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: _theme.textTheme.subtitle1,
                        ),
                        description != null
                            ? Text(
                                description,
                                style: _theme.textTheme.caption,
                              )
                            : Container(),
                        Row(
                          children: [
                            Container(
                              width: _size.width * 0.5,
                              child: Text(
                                address,
                                style: _theme.textTheme.subtitle2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        // VerticalGap(
                        //   height: KDefaultPadding / 4,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_purple500_sharp,
                              color: KPrimaryColor,
                            ),
                            HorizontalGap(
                              width: 5.0,
                            ),
                            Text(
                              rating.toString(),
                              style: _theme.textTheme.caption,
                            ),
                            Spacer(),
                            // ignore: deprecated_member_use
                            isSelectable
                                ? Container()
                                : TextButton(
                                    child: Text(
                                      _translator.translate("show_more"),
                                      style: _theme.textTheme.subtitle2,
                                    ),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => KPrimaryColor)),
                                    onPressed: () => Navigator.pushNamed(
                                        context, BranchProfile.routeName),
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
