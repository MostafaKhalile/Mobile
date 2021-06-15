import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Models/client/brancheData/company_employee.dart';
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
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: selectable ?? false ? onPressed : () => null,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
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
                          ? NetworkImage(KAPIURL + companyEmployee.image)
                          : AssetImage("assets/images/profile_photo.png")),
                  border: selectable ?? false
                      ? Border.all(
                          color: isSelected ?? false
                              ? KPrimaryColor
                              : Colors.transparent,
                          width: 3)
                      : Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            VerticalGap(
              height: KdefaultPadding / 2,
            ),
            companyEmployee != null
                ? SizedBox(
                    width: _size.width * 0.3,
                    child: Text(companyEmployee.employeeName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.caption.copyWith(
                            fontWeight: isSelected ?? false
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ?? false
                                ? KPrimaryColor
                                : _theme.accentColor)))
                : Container(
                    color: Colors.white,
                    height: KdefaultPadding / 2,
                    width: KdefaultPadding * 2,
                  )
          ],
        ),
      ),
    );
  }
}
