import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class OrderCard extends StatefulWidget {
  // final Order order;
  final double duration;
  final int index;
  final int statusCode;

  const OrderCard(
      {Key key,
      // this.order,
      this.duration,
      this.index,
      this.statusCode})
      : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Color themeColor;
  double start;
  double end;
  Locale locale;
  Color getThemeColor(int status) {
    switch (status) {
      case 19: //مؤكد من الأدمن
        {
          return Colors.green;
        }
        break;
      case 20: //مؤكد من الفنى
        {
          return Colors.yellow.shade900;
        }
        break;
      case 41: // فى الطريق
        {
          return Colors.lightBlue;
        }
        break;
      case 42: // موقوف
        {
          return Colors.redAccent;
        }
        break;
      case 35: // تم إصدار الفاتورة
        {
          return Colors.green;
        }
        break;
      case 40: // تم اللإلغاء
        {
          return Colors.red;
        }
        break;
      case 21: // تم البدء
        {
          return Colors.lightGreen;
        }
        break;
      case 22: //  انتهت
        {
          return Colors.green;
        }
        break;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    locale = BlocProvider.of<LocaleCubit>(context).state.locale;
    final ThemeData _theme = Theme.of(context);
    themeColor = getThemeColor(widget.statusCode);
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    stops: const <double>[0.03, 0.03],
                    colors: [themeColor, Colors.black]),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            child: Wrap(spacing: 10, children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: ClipPath(
                          clipper: SkewCut(),
                          child: Container(
                            width: width * 0.35,
                            height: 30,
                            decoration: BoxDecoration(
                                color: themeColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            child: Text(
                              'تم بنجاح',
                              textAlign: TextAlign.center,
                              style: _theme.textTheme.subtitle1
                                  .copyWith(height: 2),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  // margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(placeHolderImage)),
                                      borderRadius:
                                          BorderRadius.circular(defaultRadius)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " Steam Jet ",
                                      style: _theme.textTheme.subtitle2,
                                    ),
                                    Text("7/5/2021    11:31 PM",
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.justify,
                                        maxLines: 4,
                                        style: _theme.textTheme.caption)
                                  ],
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 5.0,
                            dense: true,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.white70,
                        width: 2,
                        endIndent: 2,
                        indent: 2,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Spacer(),
                              const Expanded(
                                child: Text(
                                  "#1234",
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '50 - 75 ${AppLocalizations.of(context).translate('EGP')}',
                                  style: _theme.textTheme.caption,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '5 Services',
                                  style: _theme.textTheme.caption,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        )),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}

class SkewCut extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);

    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(SkewCut oldClipper) => false;
}
