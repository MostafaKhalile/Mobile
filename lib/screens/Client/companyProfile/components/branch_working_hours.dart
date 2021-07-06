import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'info_card_title.dart';

class BranchWorkingHours extends StatelessWidget {
  const BranchWorkingHours({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    final Size _size = MediaQuery.of(context).size;
    return SizedBox(
        width: _size.width,
        child: Card(
            elevation: 10,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: 5),
                child: Wrap(children: [
                  InfoCardHeader(
                    title: _translator.translate("workingHours"),
                    icon: Icons.access_time,
                  ),
                  const WorkingDayHours(
                    day: "Saturday",
                    start: "10:00PM",
                    end: "12:00PM",
                  )
                ]))));
  }
}

class WorkingDayHours extends StatelessWidget {
  final String day;
  final String start;
  final String end;
  const WorkingDayHours({
    Key key,
    this.day,
    this.start,
    this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: _theme.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            start,
            style: _theme.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const Text("\t ــ \t"),
          Text(
            end,
            style: _theme.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
