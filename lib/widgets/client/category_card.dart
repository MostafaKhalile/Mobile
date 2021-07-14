import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final double width;

  const CategoryCard({Key key, this.category, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/CompaniesListPage",
          arguments: category),
      child: SizedBox(
        // margin: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 4),
                  padding: const EdgeInsets.all(2),
                  width: width ?? 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(defaultRadius)),
                      image: DecorationImage(
                          image: (category?.image != null)
                              ? NetworkImage(
                                      NetworkConstants.baseUrl + category.image)
                                  as ImageProvider
                              : const AssetImage(placeHolderCover),
                          // alignment: Alignment.center,
                          fit: BoxFit.fill)),
                )),
            const SizedBox(
              height: 5,
            ),
            if (category?.categoryEn != null)
              Text(
                category.categoryEn,
                style: Theme.of(context).textTheme.subtitle1,
              )
            else
              Container(
                width: 120,
                height: 30,
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
