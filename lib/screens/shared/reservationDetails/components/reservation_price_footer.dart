import 'package:flutter/material.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';

class ReservationServicesPriceFooter extends StatelessWidget {
  const ReservationServicesPriceFooter({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);

    return SizedBox(
      width: _size.width,
      height: 60,
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
    );
  }
}
