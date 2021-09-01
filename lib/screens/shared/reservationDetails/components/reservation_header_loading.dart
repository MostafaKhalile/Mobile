import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/utils/path_skew_cut.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';

class ReservationInfoHeaderLoading extends StatelessWidget {
  const ReservationInfoHeaderLoading({
    Key? key,
    required this.themeColor,
    required this.reservation,
  }) : super(key: key);

  final Color? themeColor;
  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return ShimmerEffect(
      child: Column(
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
                                reservation.orderStatus!,
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
                          "# ${reservation.orderCode}",
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
                                            image: (reservation
                                                        .orderImageFrom !=
                                                    null)
                                                ? NetworkImage(NetworkConstants
                                                            .baseUrl +
                                                        reservation
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reservation.orderFrom!,
                                        style: _theme.textTheme.subtitle2,
                                      ),
                                      SizedBox(
                                        width: _size.width * 0.3,
                                        child: Text("",
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
                          children: const <Widget>[
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SpecialistCard(
                                  selectable: false,
                                  companyEmployee: CompanyEmployee(
                                      employeeName: "", employeeId: 0, raty: 5),
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
      ),
    );
  }
}
