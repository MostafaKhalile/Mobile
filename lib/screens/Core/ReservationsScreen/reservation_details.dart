import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/reservationDetailsBloc/reservationdetails_bloc.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Models/reservations/reservationDetails/order_service.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class ReservationDetailsScreen extends StatefulWidget {
  static const String routeNAme = "/reservationDetailsScreen";
  const ReservationDetailsScreen({Key key, this.reservation}) : super(key: key);
  final Reservation reservation;

  @override
  _ReservationDetailsScreenState createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen>
    with TickerProviderStateMixin {
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 0.5,
  );
  AnimationController _controller;
  bool loading = false;
  bool selected = false;

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
          return AppColors.pendingColor;
        }
        break;
      case "complete": //مؤكد من الأدمن
        {
          return AppColors.doneColor;
        }
        break;
    }
    return Colors.grey;
  }

  Color themeColor;
  final ScrollController _scrollController =
      ScrollController(); // set controller on scrolling
  bool _show = true;
  @override
  void initState() {
    BlocProvider.of<ReservationdetailsBloc>(context)
        .add(GetReservationDetails(widget.reservation.orderId));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    handleScroll();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _show = false;
    });
  }

  Future<void> handleScroll() async => _scrollController.addListener(() {
        if (_scrollController.position.userScrollDirection ==
                ScrollDirection.reverse &&
            selected == false) {
          hideFloationButton();
        }
        if (_scrollController.position.userScrollDirection ==
                ScrollDirection.forward &&
            selected == false) {
          showFloationButton();
        }
      });

  int currentStep = 0;

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
              child:
                  BlocBuilder<ReservationdetailsBloc, ReservationdetailsState>(
                builder: (context, state) {
                  Widget widget;
                  if (state is ReservationdetailsSuccess) {
                    widget = ReservationInfHeaderData(
                        themeColor: themeColor,
                        currentStatus: reservation.orderStatus,
                        reservation: state.reservationDetails);
                  } else {
                    widget = ReservationInfoHeaderLoading(
                      themeColor: themeColor,
                      reservation: reservation,
                    );
                  }
                  return widget;
                },
              ),
            ),
            const Divider(
              color: Colors.white70,
              thickness: 0.5,
              endIndent: 10,
              indent: 10,
            ),
            Container(
                width: _size.width,
                height: 40,
                color: AppColors.darkGreyColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        reservation.orderOrderDate,
                        style: _theme.textTheme.subtitle1,
                      ),
                      Text(
                          "${getTimePeriods(reservation?.orderOrderTime).format(context).split(' ')[0]} ${getTimePeriods(reservation?.orderOrderTime).format(context).split(' ')[1]}",
                          style: _theme.textTheme.subtitle1)
                    ])),
            BlocBuilder<ReservationdetailsBloc, ReservationdetailsState>(
              builder: (context, state) {
                Widget widget;
                if (state is ReservationdetailsSuccess) {
                  if (state.reservationDetails.orderService.length < 3 ||
                      state.reservationDetails.orderService == null) {
                    _show = true;
                  }
                  widget = Expanded(
                    child: Column(
                      children: [
                        StepperBuilder(
                          currentStep: currentStep,
                          theme: _theme,
                          state: state,
                        ),
                        Expanded(
                          flex: 2,
                          child: ListView.separated(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(top: 20),
                              itemCount:
                                  state.reservationDetails.orderService.length,
                              separatorBuilder: (_, i) => const VerticalGap(),
                              itemBuilder: (context, i) {
                                return OrderServiceCard(
                                  service:
                                      state.reservationDetails.orderService[i],
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                } else {
                  widget = Container();
                }
                return widget;
              },
            )
          ],
        ),
        floatingActionButton: AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: _show ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            // The green box must be a child of the AnimatedOpacity widget.
            child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400],
                          spreadRadius: 2,
                          blurRadius: 5),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    border: Border.all(width: 8, color: Colors.white)),
                child: FittedBox(
                    child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        onPressed: loading
                            ? null
                            : () {
                                setState(() {
                                  if (!selected) {
                                    _controller.forward();
                                  } else {
                                    _controller.reverse();
                                  }
                                  selected = !selected;
                                });
                              },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RotationTransition(
                                turns: turnsTween.animate(_controller),
                                child: SvgPicture.asset(
                                  "assets/svg/double_arrow.svg",
                                  height: 15,
                                )),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("control_order"),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                color: _theme.accentColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ))))),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        bottomSheet: AnimatedContainer(
          padding: const EdgeInsets.all(10),
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          height: selected ? _size.height * 0.35 : 0.0,
          width: _size.width,
          decoration: BoxDecoration(
              color: _theme.scaffoldBackgroundColor,
              border:
                  const Border.fromBorderSide(BorderSide(color: Colors.white)),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(defaultRadius),
                  topLeft: Radius.circular(defaultRadius))),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.center,
            direction: Axis.vertical,
            children: [
              AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: selected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: SizedBox(
                    height: double.infinity,
                    width: _size.width,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.location_on_rounded,
                                  size: 30,
                                  semanticLabel: "Get Directions",
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.call,
                                  size: 30,
                                ),
                                color: Colors.green,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        persistentFooterButtons: [
          SizedBox(
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
          ),
        ],
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

class OrderServiceCard extends StatelessWidget {
  const OrderServiceCard({
    Key key,
    this.service,
  }) : super(key: key);

  final OrderService service;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Card(
        color: _theme.scaffoldBackgroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
            width: _size.width * .85,
            child: Wrap(children: <Widget>[
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (service?.imageService != null)
                              ? NetworkImage(NetworkConstants.baseUrl +
                                  service?.imageService) as ImageProvider
                              : const AssetImage(placeHolderImage)),
                      borderRadius: BorderRadius.circular(defaultRadius)),
                ),
                title: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: service.servicesAr,
                          style: _theme.textTheme.subtitle2,
                        ),
                      ),
                    ),
                  ])
                ]),
                subtitle: SizedBox(
                  width: _size.width * 0.15,
                  child: Text(service.description,
                      overflow: TextOverflow.clip,
                      // textAlign: TextAlign.justify,
                      // maxLines: 4,
                      style: _theme.textTheme.caption),
                ),
                trailing: Column(children: [
                  Text(
                    '${service.priceFrom} - ${service.priceTo} ${_translator.translate('EGP')}',
                    style: _theme.textTheme.caption,
                  ),
                  Text(
                    '${service.fullTime} ${_translator.translate('minute')}',
                    style: _theme.textTheme.caption,
                  ),
                ]),
                // isThreeLine: true,
                contentPadding: const EdgeInsets.all(10),
                horizontalTitleGap: 5.0,
              ),
            ])));
  }
}

class StepperBuilder extends StatelessWidget {
  const StepperBuilder({
    Key key,
    @required this.currentStep,
    @required ThemeData theme,
    @required this.state,
  })  : _theme = theme,
        super(key: key);

  final int currentStep;
  final ThemeData _theme;
  final ReservationdetailsSuccess state;
  @override
  Widget build(BuildContext context) {
    final status = state.reservationDetails.orderStatus;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 100,
      width: MediaQuery.of(context).size.width * .98,
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  canvasColor: Colors.black,
                  accentColor: AppColors.primaryColor,
                  brightness: Brightness.dark),
              child: EnhanceStepper(
                horizontalTitlePosition: HorizontalTitlePosition.bottom,
                horizontalLinePosition: HorizontalLinePosition.center,
                type: StepperType.horizontal,
                stepIconSize: 25,
                physics: const ClampingScrollPhysics(),
                currentStep: currentStep,
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row();
                },
                steps: [
                  EnhanceStep(
                    title: Text(
                      'Request',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.assent ||
                        status.confirm ||
                        status.done ||
                        status.finish,
                    state: (status.assent ||
                            status.confirm ||
                            status.done ||
                            status.finish)
                        ? StepState.complete
                        : StepState.indexed,
                    content: Container(),
                  ),
                  EnhanceStep(
                    title: Text(
                      'Arrive',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.confirm || status.done || status.finish,
                    state: status.confirm || status.done || status.finish
                        ? StepState.complete
                        : StepState.disabled,
                    content: Container(),
                  ),
                  EnhanceStep(
                    title: Text(
                      'Complete',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.confirm || status.done || status.finish,
                    state: (status.confirm || status.done || status.finish)
                        ? StepState.complete
                        : StepState.disabled,
                    content: Container(),
                  ),
                  EnhanceStep(
                    title: Text(
                      'Reviews',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.finish,
                    state:
                        status.finish ? StepState.complete : StepState.indexed,
                    content: Container(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReservationInfHeaderData extends StatelessWidget {
  const ReservationInfHeaderData({
    Key key,
    @required this.themeColor,
    @required this.reservation,
    @required this.currentStatus,
  }) : super(key: key);

  final Color themeColor;
  final String currentStatus;
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
                              currentStatus,
                              textAlign: TextAlign.center,
                              style: _theme.textTheme.bodyText1
                                  .copyWith(height: 1.6),
                            ),
                          )),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "# ${reservation.orderData.orderCode}",
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
                                          image: (reservation?.orderData
                                                      ?.orderImageFrom !=
                                                  null)
                                              ? NetworkImage(
                                                      NetworkConstants.baseUrl +
                                                          reservation?.orderData
                                                              ?.orderImageFrom)
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
                                      reservation.orderData.orderBranch,
                                      style: _theme.textTheme.subtitle2,
                                    ),
                                    SizedBox(
                                      width: _size.width * 0.3,
                                      child: Text(
                                          reservation.orderData.orderAddress ??
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
                    const Spacer(),
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
                                        reservation.orderData.employeeName,
                                    employeeId:
                                        reservation.orderData.employeeId,
                                    image: reservation.orderData.employeeImage,
                                    raty: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //     flex: 3,
                    //     child: Container(
                    //       height: 100,
                    //       padding: const EdgeInsets.symmetric(horizontal: 10),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Spacer(),
                    //           Expanded(
                    //             child: Text(
                    //               "# ${reservation.orderData.orderCode}",
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                 child: IconButton(
                    //                   icon:
                    //                       const Icon(Icons.location_on_rounded),
                    //                   onPressed: () {},
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 child: IconButton(
                    //                   icon: const Icon(
                    //                     Icons.call,
                    //                   ),
                    //                   onPressed: () {},
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           const Spacer(),
                    //         ],
                    //       ),
                    //     )),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}

class ReservationInfoHeaderLoading extends StatelessWidget {
  const ReservationInfoHeaderLoading({
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
                                reservation.orderStatus,
                                textAlign: TextAlign.center,
                                style: _theme.textTheme.bodyText1
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
                                                        ?.orderImageFrom !=
                                                    null)
                                                ? NetworkImage(NetworkConstants
                                                            .baseUrl +
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reservation.orderFrom,
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
                      const Spacer(),
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
