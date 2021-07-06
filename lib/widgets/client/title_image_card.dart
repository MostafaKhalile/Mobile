import 'package:flutter/material.dart';
import 'package:techtime/Helpers/api_urls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Models/client/category.dart';

class TitleImageCard extends StatelessWidget {
  final Category category;
  const TitleImageCard({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pushNamed(context, "/CompaniesListPage",
            arguments: category),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: KdefaultPadding),
          height: 200,
          decoration: BoxDecoration(
              border: Border.all(color: KPrimaryColor),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius:
                  const BorderRadius.all(Radius.circular(KdefaultRadius)),
              image: DecorationImage(
                  image: category?.image != null
                      ? NetworkImage(KAPIURL + category.image) as ImageProvider
                      : const AssetImage(KPlaceHolderImage),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  // alignment: Alignment.center,
                  fit: BoxFit.fill)),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: KdefaultPadding),
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
