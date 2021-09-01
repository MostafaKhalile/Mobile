import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/reservationDetailsBloc/reservationdetails_bloc.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';
import 'package:techtime/Widgets/core/pulsing_float_action_button.dart';

import 'package:techtime/Widgets/core/vertical_gab.dart';

import '../resrevationController/reservation_controller.dart';
import 'components/order_service_card.dart';
import 'components/order_steps_builder.dart';
import 'components/reservation_header_data.dart';
import 'components/reservation_header_loading.dart';
import 'components/reservation_price_footer.dart';

class ReservationDetailsScreen extends StatefulWidget {
  static const String routeNAme = "/reservationDetailsScreen";
  const ReservationDetailsScreen({Key? key, this.reservation})
      : super(key: key);
  final Reservation? reservation;

  @override
  _ReservationDetailsScreenState createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen>
    with TickerProviderStateMixin {
  final Tween<double> doubleArrowRotatingController = Tween<double>(
    begin: 0,
    end: 0.5,
  );
  late AnimationController _bottomModalAnimator;
  bool selected = false;
  late AnimationController _pulsingAnimationController;

  Color? themeColor;
  final ScrollController _scrollController =
      ScrollController(); // set controller on scrolling
  bool _show = true;
  int currentStep = 0;
  @override
  void initState() {
    BlocProvider.of<ReservationdetailsBloc>(context)
        .add(GetReservationDetails(widget.reservation!.orderId));
    _bottomModalAnimator = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pulsingAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _pulsingAnimationController.repeat(reverse: true);

    handleScroll();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _bottomModalAnimator.dispose();
    _pulsingAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    final Reservation reservation = (widget.reservation != null)
        ? widget.reservation!
        : const Reservation(orderCode: "");
    themeColor =
        const ReservationDetails().getThemeColor(reservation.orderStatus);
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
            Container(
                width: _size.width,
                height: 40,
                color: AppColors.darkGreyColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        reservation.orderOrderDate!,
                        style: _theme.textTheme.subtitle1,
                      ),
                      Text(
                          "${getTimePeriods(reservation.orderOrderTime).format(context).split(' ')[0]} ${getTimePeriods(reservation.orderOrderTime).format(context).split(' ')[1]}",
                          style: _theme.textTheme.subtitle1)
                    ])),
            BlocBuilder<ReservationdetailsBloc, ReservationdetailsState>(
              builder: (context, state) {
                Widget widget;
                if (state is ReservationdetailsSuccess) {
                  //ToDo: function decoupling ;
                  if (state.reservationDetails.orderService!.length < 3 ||
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
                                  state.reservationDetails.orderService!.length,
                              separatorBuilder: (_, i) => const VerticalGap(),
                              itemBuilder: (context, i) {
                                return OrderServiceCard(
                                  service:
                                      state.reservationDetails.orderService![i],
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
        floatingActionButton: PulsingFloatActionButton(
          onPressed: () {
            setState(() {
              if (!selected) {
                _bottomModalAnimator.forward();
              } else {
                _bottomModalAnimator.reverse();
              }
              selected = !selected;
            });
          },
          rotatingController: _bottomModalAnimator,
          show: _show,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        bottomSheet: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          height: selected ? _size.height * 0.45 : 0.0,
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
                      child: BlocBuilder<ReservationdetailsBloc,
                          ReservationdetailsState>(
                        builder: (context, state) {
                          return Stack(
                            children: [
                              if (state is ReservationdetailsSuccess)
                                Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  width: _size.width,
                                  height: double.infinity,
                                  child: const SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: ReservationControllersView(),
                                  ),
                                )
                              else
                                Container(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    if (state is ReservationdetailsSuccess)
                                      IconButton(
                                        icon: const Icon(
                                          Icons.location_on_rounded,
                                          size: 30,
                                          semanticLabel: "Get Directions",
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () => openMapsSheet(
                                          context,
                                          state.reservationDetails.orderData!
                                              .latitude!,
                                          state.reservationDetails.orderData!
                                              .longitude!,
                                        ),
                                      )
                                    else
                                      Container(),
                                    if (state is ReservationdetailsSuccess)
                                      IconButton(
                                          icon: const Icon(
                                            Icons.call,
                                            size: 30,
                                          ),
                                          color: Colors.green,
                                          onPressed: () {
                                            FlutterPhoneDirectCaller.callNumber(
                                                state.reservationDetails
                                                    .orderData!.orderMobile
                                                    .toString());
                                          })
                                    else
                                      Container()
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                ),
              ]),
        ),
        persistentFooterButtons: [
          ReservationServicesPriceFooter(reservation: reservation),
        ],
      ),
    );
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

  Future<void> openMapsSheet(
      BuildContext context, String lat, String long) async {
    try {
      final coords = Coords(double.parse(lat), double.parse(long));
      final title = widget.reservation!.orderFrom;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title!,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  TimeOfDay getTimePeriods(String? time) {
    final TimeOfDay interval = TimeOfDay(
        hour: int.parse(time.toString().split(":")[0]),
        minute: int.parse(time.toString().split(":")[1]));

    return interval;
  }
}
