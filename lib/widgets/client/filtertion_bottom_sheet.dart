import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class FilterationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _translator.translate("services"),
            style: _theme.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                  child: CheckboxGroup(
                      activeColor: AppColors.primaryColor,
                      checkColor: Theme.of(context).scaffoldBackgroundColor,
                      labelStyle: Theme.of(context).textTheme.subtitle2,
                      labels: <String>[
                        _translator.translate("carcare"),
                        _translator.translate("workspace"),
                        _translator.translate("playstation"),
                      ],
                      onSelected: (List<String> checked) =>
                          print(checked.toString()))),
              Expanded(
                  child: CheckboxGroup(
                      activeColor: AppColors.primaryColor,
                      checkColor: Theme.of(context).scaffoldBackgroundColor,
                      labelStyle: Theme.of(context).textTheme.subtitle2,
                      labels: <String>[
                        _translator.translate("beautyCenter"),
                        _translator.translate("gym"),
                        _translator.translate("men'sSalon"),
                      ],
                      onSelected: (List<String> checked) =>
                          print(checked.toString()))),
            ],
          ),
          Text(
            _translator.translate("filterBy"),
            style: _theme.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          RadioButtonGroup(
              activeColor: AppColors.primaryColor,
              labelStyle: _theme.textTheme.subtitle2,
              labels: <String>[
                _translator.translate("alphabetical"),
                _translator.translate("theNearest"),
                _translator.translate("top_to_Low_rated"),
                _translator.translate("low_to_top_rated"),
              ],
              onSelected: (String selected) => print(selected))
        ],
      ),
    );
  }
}
