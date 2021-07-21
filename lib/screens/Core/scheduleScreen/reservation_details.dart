import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/reservationDetailsBloc/reservationdetails_bloc.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';

class ReservationDetailsScreen extends StatefulWidget {
  static const String routeNAme = "/reservationDetailsScreen";
  const ReservationDetailsScreen({Key key, this.reservation}) : super(key: key);
  final Reservation reservation;

  @override
  _ReservationDetailsScreenState createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
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
      case "Pending..": //مؤكد من الأدمن
        {
          return const Color(0xFFF6A811);
        }
        break;
    }
    return Colors.grey;
  }

  Color themeColor;
  @override
  void initState() {
    BlocProvider.of<ReservationdetailsBloc>(context)
        .add(GetReservationDetails(widget.reservation.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    final Reservation reservation = (widget.reservation != null)
        ? widget.reservation
        : const Reservation(orderCode: "");
    themeColor = getThemeColor(reservation.orderStatus);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                width: _size.width,
                color: Colors.black,
                child: ShimmerEffect(
                  child: ReservationInfoHeader(
                    themeColor: themeColor,
                    reservation: reservation,
                  ),
                )),
            const Divider(
              color: Colors.white70,
              thickness: 0.5,
              endIndent: 10,
              indent: 10,
            )
          ],
        ),
        persistentFooterButtons: [
          SizedBox(
            width: _size.width,
            height: 60,
            child: ShimmerEffect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Total : ${reservation.orderTotalService}  Services",
                    style: _theme.textTheme.headline6,
                  ),
                  const HorizontalGap(),
                  Text(
                    "${reservation.orderFromTotalOrder} - ${reservation.orderToTotalOrder}  EGP",
                    style: _theme.textTheme.headline6,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReservationInfoHeader extends StatelessWidget {
  const ReservationInfoHeader({
    Key key,
    @required this.themeColor,
    @required this.reservation,
  }) : super(key: key);

  final Color themeColor;
  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  color: Colors.black,
                ),
                child: ClipPath(
                    clipper: SkewCut(),
                    child: Container(
                      width: _size.width * 0.35,
                      height: 30,
                      decoration: BoxDecoration(
                        color: themeColor,
                      ),
                      child: Text(
                        reservation.orderStatus,
                        textAlign: TextAlign.center,
                        style: _theme.textTheme.subtitle1.copyWith(height: 2),
                      ),
                    )),
              ),
            ),
          ],
        ),
        Container(
            width: _size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Wrap(
              children: [
                Row(
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
                                  height: 70,
                                  width: 70,
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
                                                  placeHolderCover))),
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
                                    SizedBox(
                                      width: _size.width * 0.3,
                                      child: Text(
                                          "Alexandria, Miami. Alexandria, Miami. Alexandria, Miami. Alexandria, Miami. Alexandria, Miami. Alexandria, Miami. ",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: _theme.textTheme.caption),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 10.0,
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
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Expanded(
                                child: Text(
                                  "# ${reservation.orderCode}",
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      icon:
                                          const Icon(Icons.location_on_rounded),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.call,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ))
      ],
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
