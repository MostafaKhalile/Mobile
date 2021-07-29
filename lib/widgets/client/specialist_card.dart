import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({
    Key key,
    this.isSelected,
    this.onPressed,
    this.selectable,
    this.companyEmployee,
  }) : super(key: key);
  final CompanyEmployee companyEmployee;

  final bool isSelected;
  final bool selectable;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: selectable ?? false ? onPressed : () => null,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        height: 95,
        width: _size.width * 0.2,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: companyEmployee?.image != null
                          ? NetworkImage(NetworkConstants.baseUrl +
                              companyEmployee.image) as ImageProvider
                          : const AssetImage(
                              "assets/images/profile_photo.png")),
                  border: selectable ?? false
                      ? Border.all(
                          color: isSelected ?? false
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          width: 3)
                      : Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
            ),
            const VerticalGap(
              height: defaultPadding / 2,
            ),
            if (companyEmployee != null)
              SizedBox(
                  width: _size.width * 0.3,
                  child: Text(companyEmployee.employeeName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: _theme.textTheme.caption.copyWith(
                          fontWeight: isSelected ?? false
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ?? false
                              ? AppColors.primaryColor
                              : _theme.accentColor)))
            else
              Container(
                color: Colors.white,
                height: defaultPadding / 2,
                width: defaultPadding * 2,
              ),
            if (companyEmployee.raty != null)
              RatingBarIndicator(
                rating: double.parse(companyEmployee.raty.toString()),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 14.0,
              )
            else
              Container()
          ],
        ),
      ),
    );
  }
}
