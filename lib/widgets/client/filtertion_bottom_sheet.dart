import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class FilterationBody extends StatelessWidget {
  final CustomGroupController customController =
      CustomGroupController(isMultipleSelection: true);
  final GroupController controller = GroupController();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    final List<String> _categories = [
      _translator.translate("carcare")!,
      _translator.translate("workspace")!,
      _translator.translate("playstation")!,
      _translator.translate("beautyCenter")!,
      _translator.translate("gym")!,
      _translator.translate("men'sSalon")!,
    ];
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _translator.translate("services")!,
            style: _theme.textTheme.subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: _size.height * .2,
              width: _size.width,
              child: SizedBox(
                height: _size.height * 0.2,
                width: _size.width,
                child: CustomGroupedCheckbox.grid(
                  controller: customController,
                  itemBuilder: (ctx, index, value, isDisabled) {
                    return CheckboxListTile(
                      activeColor: AppColors.primaryColor,
                      checkColor: _theme.scaffoldBackgroundColor,
                      onChanged: (value) {},
                      title: Text(
                        _categories[index],
                        style: _theme.textTheme.caption,
                      ),
                      value: value,
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 40,
                      crossAxisCount: 2),
                  values: _categories,
                ),
              )),
          Text(
            _translator.translate("filterBy")!,
            style: _theme.textTheme.subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SimpleGroupedCheckbox<String>(
            controller: controller,
            itemsTitle: <String>[
              _translator.translate("alphabetical")!,
              _translator.translate("theNearest")!,
              _translator.translate("top_to_Low_rated")!,
              _translator.translate("low_to_top_rated")!,
            ],
            values: [
              _translator.translate("alphabetical")!,
              _translator.translate("theNearest")!,
              _translator.translate("top_to_Low_rated")!,
              _translator.translate("low_to_top_rated")!,
            ],
            groupStyle: GroupStyle(
                activeColor: AppColors.primaryColor,
                itemTitleStyle: const TextStyle(fontSize: 13)),
          )
        ],
      ),
    );
  }
}
