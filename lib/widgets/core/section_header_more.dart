import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class SectionHeaderMore extends StatelessWidget {
  const SectionHeaderMore({
    Key key,
    @required this.header,
    this.onPressed,
  }) : super(key: key);
  final String header;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: KDefaultPadding),
          child: Text(
            header,
            style: _theme.textTheme.subtitle2
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: onPressed,
          splashColor: Colors.transparent,
          child: Text(
            _translator.translate("seeAll"),
            style: _theme.textTheme.subtitle2
                .copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
