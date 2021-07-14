import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/category.dart';

class TitleImageCard extends StatelessWidget {
  final Category category;
  final double height;
  const TitleImageCard({
    Key key,
    this.category,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pushNamed(context, "/CompaniesListPage",
            arguments: category),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
          height: height,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultRadius)),
              image: DecorationImage(
                  image: category?.image != null
                      ? NetworkImage(NetworkConstants.baseUrl + category.image)
                          as ImageProvider
                      : const AssetImage(placeHolderImage),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  // alignment: Alignment.center,
                  fit: BoxFit.fill)),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  category?.categoryEn ?? '',
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ));
  }
}
