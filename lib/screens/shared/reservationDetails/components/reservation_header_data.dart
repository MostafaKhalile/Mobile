import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/utils/path_skew_cut.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';

class ReservationInfHeaderData extends StatelessWidget {
  const ReservationInfHeaderData({
    Key? key,
    required this.themeColor,
    required this.reservation,
    required this.currentStatus,
  }) : super(key: key);

  final Color? themeColor;
  final String? currentStatus;
  final ReservationDetails reservation;

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
              alignment: Alignment.topCenter,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10)),
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
                              currentStatus!,
                              textAlign: TextAlign.center,
                              style: _theme.textTheme.bodyText1!
                                  .copyWith(height: 1.6),
                            ),
                          )),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "# ${reservation.orderData!.orderCode}",
                        style: _theme.textTheme.headline6,
                      ),
                    ),
                  ],
                ),
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
                                          image: (reservation.orderData
                                                      ?.orderImageFrom !=
                                                  null)
                                              ? NetworkImage(
                                                      NetworkConstants.baseUrl +
                                                          reservation.orderData!
                                                              .orderImageFrom!)
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
                                      reservation.orderData!.orderBranch!,
                                      style: _theme.textTheme.subtitle2,
                                    ),
                                    SizedBox(
                                      width: _size.width * 0.3,
                                      child: Text(
                                          reservation.orderData!.orderAddress ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: _theme.textTheme.caption),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 10.0,
                            dense: false,
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    const SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.white70,
                        width: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10),
                      child: Row(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SpecialistCard(
                                selectable: false,
                                companyEmployee: CompanyEmployee(
                                    employeeName:
                                        reservation.orderData!.employeeName ??
                                            reservation.orderData!.orderBranch,
                                    employeeId:
                                        reservation.orderData!.employeeId ?? 0,
                                    image: reservation
                                            .orderData!.employeeImage ??
                                        reservation.orderData!.orderImageFrom,
                                    raty: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
