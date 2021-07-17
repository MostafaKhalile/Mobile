import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Screens/Core/reservation_details.dart';

class ReservationCard extends StatefulWidget {
  // final Order order;
  final double duration;
  final int index;
  final int statusCode;
  final Reservation reservation;

  const ReservationCard(
      {Key key,
      // this.order,
      this.duration,
      this.index,
      this.statusCode,
      this.reservation})
      : super(key: key);

  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  Color themeColor;
  double start;
  double end;
  Locale locale;
  Color getThemeColor(String status) {
    switch (status) {
      case "Acceptable": //مؤكد من الأدمن
        {
          return AppColors.secondryColor;
        }
        break;
      case "Processing": //مؤكد من الأدمن
        {
          return Colors.green[800];
        }
        break;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    locale = BlocProvider.of<LocaleCubit>(context).state.locale;
    final ThemeData _theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;
    final Reservation reservation = (widget.reservation != null)
        ? widget.reservation
        : const Reservation(orderCode: "1234");
    return GestureDetector(
      onTap: () => Navigator.push(context,
          CupertinoPageRoute(builder: (ctx) => const ReservationDetails())),
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
                gradient: LinearGradient(stops: const <double>[
                  0.03,
                  0.03
                ], colors: [
                  getThemeColor(reservation?.orderStatus ?? ""),
                  Colors.black
                ]),
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
                                color: getThemeColor(
                                    reservation?.orderStatus ?? ""),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            child: Text(
                              reservation?.orderStatus ?? "",
                              textAlign: TextAlign.center,
                              style: _theme.textTheme.bodyText1
                                  .copyWith(height: 1.6),
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
                                      image: DecorationImage(
                                          image: (reservation?.orderImageFrom !=
                                                  null)
                                              ? NetworkImage(
                                                      NetworkConstants.baseUrl +
                                                          reservation
                                                              .orderImageFrom)
                                                  as ImageProvider
                                              : const AssetImage(
                                                  placeHolderCover)),
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
                                      reservation?.orderFrom ?? "",
                                      style: _theme.textTheme.subtitle2,
                                    ),
                                    Row(
                                      children: [
                                        Text(reservation?.orderOrderDate ?? '',
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.justify,
                                            maxLines: 4,
                                            style: _theme.textTheme.caption),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: reservation
                                                          ?.orderOrderTime !=
                                                      null
                                                  ? "\t\t\t${getTimePeriods(reservation?.orderOrderTime).format(context).split(' ')[0]}"
                                                  : "",
                                              style: _theme.textTheme.caption,
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: '\t',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: reservation
                                                              ?.orderOrderTime !=
                                                          null
                                                      ? getTimePeriods(reservation
                                                              ?.orderOrderTime)
                                                          .format(context)
                                                          .split(' ')[1]
                                                      : "",
                                                )
                                              ],
                                            ))
                                      ],
                                    )
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
                              Expanded(
                                child: Text(
                                  "# ${reservation?.orderCode ?? ''}",
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${reservation?.orderFromTotalOrder ?? ''} - ${reservation?.orderToTotalOrder ?? ''} ${AppLocalizations.of(context).translate('EGP')}',
                                  style: _theme.textTheme.caption,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${reservation?.orderTotalService ?? ''} Services',
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

  TimeOfDay getTimePeriods(String time) {
    final TimeOfDay interval = TimeOfDay(
        hour: int.parse(time.toString().split(":")[0]),
        minute: int.parse(time.toString().split(":")[1]));

    return interval;
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
