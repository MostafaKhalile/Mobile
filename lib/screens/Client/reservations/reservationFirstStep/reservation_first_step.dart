import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/branchEmployeesBloc/brancheemployees_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/orderBlocs/orderDateTimeBloc/orderdatetime_bloc.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/newServicesReservation/newservicesreservation_bloc.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/Models/Params/create_order_first_step_params.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';
import 'package:techtime/Models/client/orders/order_date_time.dart';
import 'package:techtime/Screens/Client/branchProfile/branch_profile.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/widgets/client/branch_card.dart';
import 'package:intl/intl.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class ReservationFirstStep extends StatefulWidget {
  static const String routeName = "/order_first_step";
  final List<CompanyBranche>? companyBranches;
  final int? branchID;
  final ReservationType? reservationType;
  final List<CompanyService>? selectedServices;

  const ReservationFirstStep(
      {Key? key,
      this.companyBranches,
      this.branchID,
      required this.reservationType,
      this.selectedServices})
      : super(key: key);

  @override
  ReservationFirstStepState createState() => ReservationFirstStepState();
}

class ReservationFirstStepState extends State<ReservationFirstStep> {
  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  OrderDateTime? _selecteOrderdDay;
  String? _selecteOrderTime;
  List<String?> holidays = [];
  List<String> availableTimes = [];

  int? _selectedBranch;
  int? _selectedtime;
  int? _selectedEmployee;
  Locale? locale;
  @override
  void initState() {
    initializeReservationProcess();

    locale = BlocProvider.of<LocaleCubit>(context).state.locale;
    super.initState();
  }

  void initializeReservationProcess() {
    {
      if (widget.reservationType == ReservationType.service) {
        if (widget.companyBranches!.length == 1) {
          chooseBranch(context, widget.companyBranches![0].brancheID);
        }
        BlocProvider.of<BrancheemployeesBloc>(context)
            .add(GetBrancheEmployees(widget.companyBranches![0].brancheID));
      } else {
        BlocProvider.of<BrancheemployeesBloc>(context)
            .add(GetBrancheEmployees(widget.branchID));
      }
      if (widget.reservationType == ReservationType.service) {
        if (widget.companyBranches!.length == 1) {
          chooseBranch(context, widget.companyBranches![0].brancheID);
        }
        BlocProvider.of<OrderDateTimeBloc>(context)
            .add(GetOrderDateTimes(widget.companyBranches![0].brancheID));
      } else {
        BlocProvider.of<OrderDateTimeBloc>(context)
            .add(GetOrderDateTimes(widget.branchID));
        chooseBranch(context, widget.branchID);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _translator.translate("book_appointment")!,
            style: _theme.textTheme.headline6!.copyWith(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SizedBox(
            width: _size.width,
            height: _size.height,
            child: Column(children: [
              Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                if (widget.reservationType ==
                                    ReservationType.service)
                                  Column(
                                    children: [
                                      SubTitle(
                                          text: _translator
                                              .translate("choose_branche")),
                                      SizedBox(
                                        height: 150,
                                        child: ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: defaultPadding),
                                            itemCount:
                                                widget.companyBranches!.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            separatorBuilder: (_, i) =>
                                                const HorizontalGap(),
                                            itemBuilder: (_, i) {
                                              final brancheData =
                                                  widget.companyBranches![i];
                                              return BranchCard(
                                                isSelectable: true,
                                                isSelected:
                                                    brancheData.brancheID ==
                                                        _selectedBranch,
                                                title: brancheData.brancheName,
                                                address:
                                                    brancheData.branchAddressAR,
                                                rating: 4.8,
                                                image: (brancheData.image !=
                                                        null)
                                                    ? NetworkConstants.baseUrl +
                                                        brancheData.image!
                                                    : null,
                                                onPressed: () {
                                                  chooseBranch(context,
                                                      brancheData.brancheID);
                                                },
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                else
                                  Container(),
                                const VerticalGap(
                                  height: defaultPadding / 2,
                                ),
                                BlocBuilder<OrderDateTimeBloc,
                                    OrderDateTimeState>(
                                  builder: (context, state) {
                                    if (state is OrderDateTimeSuccess) {
                                      return buildCalendarData(_translator,
                                          _theme, state.orderDateTimes);
                                    }
                                    return buildCalendarLoading(
                                        _translator, _theme);
                                  },
                                ),
                              ],
                            ),

                            //build Branch Previous work data
                            BlocConsumer<OrderDateTimeBloc, OrderDateTimeState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is OrderDateTimeSuccess) {
                                  if (_selecteOrderdDay != null) {
                                    return Column(
                                      children: [
                                        SubTitle(
                                            text: _translator
                                                .translate("select_time")),
                                        SizedBox(
                                          height: 90,
                                          child: ListView.separated(
                                              itemCount: _selecteOrderdDay!
                                                  .orderTimes!.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              separatorBuilder: (_, i) =>
                                                  const HorizontalGap(),
                                              itemBuilder: (ctx, i) =>
                                                  TimeSelectableCard(
                                                    isSelected:
                                                        i == _selectedtime,
                                                    workingHour:
                                                        _selecteOrderdDay!
                                                                .orderTimes![i]
                                                            as String,
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedtime = i;
                                                        _selecteOrderTime =
                                                            _selecteOrderdDay!
                                                                    .orderTimes![
                                                                i] as String;
                                                      });
                                                    },
                                                  )),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                                return buildWorkingHoursLoading(_translator);
                              },
                            ),

                            //choose Branch specialists
                            BlocBuilder<BrancheemployeesBloc,
                                BrancheemployeesState>(
                              builder: (context, state) {
                                if (state is BrancheemployeesSuccess) {
                                  if (state.employees.isNotEmpty) {
                                    return buildEmployeesData(_translator,
                                        _size, _theme, state.employees);
                                  } else {
                                    return Container();
                                  }
                                }
                                return buildEmployeesLoading(
                                    _translator, _size, _theme);
                              },
                            ),
                          ],
                        ),
                      )))
            ])),
        persistentFooterButtons: [
          BlocListener<NewservicesreservationBloc, NewservicesreservationState>(
            listener: (context, state) {
              if (state is NewservicesreservationSuccess) {
                BlocProvider.of<NewservicesreservationBloc>(context).add(
                    CreateNewServicesOrderSecondStep(
                        state.response.orderId!, widget.selectedServices!));
              }
              if (state is ServicesReservationSecondStepSuccess) {
                CustomToast().buildSuccessMessage(context);
                Navigator.pop(context);
              }
              if (state is NewservicesreservationFailure) {
                print("Reservation Error ${state.failure}");
              }
            },
            child: BottomBookingButton(
              onPressed: () {
                final bool isValid = _validateBooking();
                if (isValid) {
                  final PriceRange priceRange = getPriceRange();
                  print(priceRange.toJson().toString());
                  BlocProvider.of<NewservicesreservationBloc>(context).add(
                      CreateNewServicesOrderFirstStep(
                          _selectedBranch!,
                          const CreateOrderFirstStepParams().copyWith(
                              employeeRequest: _selectedEmployee.toString(),
                              orderDate: _selecteOrderdDay!.date.toString(),
                              orderTime: getTimePeriods(_selecteOrderTime)
                                  .format(context)
                                  .split(' ')[0]
                                  .toString(),
                              totalOrderFrom:
                                  priceRange.totalOrderFrom.toString(),
                              totalOrderTo:
                                  priceRange.totalOrderTo.toString())));
                }
                // Navigator.pushNamed(context, TableReservation.routeName);
              },
            ),
          )
        ]);
  }

  PriceRange getPriceRange() {
    int priceTo = 0;
    int priceFrom = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    widget.selectedServices!.forEach((element) {
      priceFrom += int.parse(element.priceFrom.toString());
    });
    // ignore: avoid_function_literals_in_foreach_calls
    widget.selectedServices!.forEach((element) {
      priceTo += int.parse(element.priceTo.toString());
    });
    widget.selectedServices!
        .map((e) => priceTo + int.parse(e.priceTo.toString()));

    return PriceRange(
        totalOrderFrom: priceFrom.toString(), totalOrderTo: priceTo.toString());
  }

  TimeOfDay getTimePeriods(String? time) {
    final TimeOfDay interval = TimeOfDay(
        hour: int.parse(time.toString().split(":")[0]),
        minute: int.parse(time.toString().split(":")[1]));

    return interval;
  }

  void chooseBranch(BuildContext context, int? branch) {
    BlocProvider.of<BrancheemployeesBloc>(context)
        .add(GetBrancheEmployees(branch));
    BlocProvider.of<OrderDateTimeBloc>(context).add(GetOrderDateTimes(branch));
    setState(() {
      _selectedBranch = branch;
      _selecteOrderdDay = null;
      _selecteOrderTime = null;
      _selectedDay = null;
      _selectedEmployee = null;
    });
  }

  bool _validateBooking() {
    return _selecteOrderTime != null &&
        _selecteOrderdDay != null &&
        // (_selectedEmployee != null) &&
        _selectedBranch != null;
  }

  ShimmerEffect buildWorkingHoursLoading(AppLocalizations _translator) {
    return ShimmerEffect(
      child: Column(
        children: [
          SubTitle(text: _translator.translate("select_time")),
          SizedBox(
            height: 90,
            child: ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, i) => const HorizontalGap(),
                itemBuilder: (ctx, i) => TimeSelectableCard(
                      isSelected: i == _selectedtime,
                      onTap: () {
                        setState(() {
                          _selectedtime = i;
                        });
                      },
                    )),
          ),
        ],
      ),
    );
  }

  Widget buildCalendarData(AppLocalizations _translator, ThemeData _theme,
      List<OrderDateTime> workDays) {
    return Column(
      children: [
        SubTitle(text: _translator.translate("pick_day")),
        TableCalendar(
          locale: locale?.languageCode ?? 'en',
          onCalendarCreated: (pageController) {
            final List<String?> tempDays = [];
            for (final day in workDays) {
              if (day.open == false) tempDays.add(day.date);
            }
            holidays = tempDays;
            print(holidays);
          },
          weekendDays: const [],
          calendarStyle: CalendarStyle(
              disabledTextStyle: TextStyle(color: Colors.grey[700]),
              todayDecoration: BoxDecoration(
                color: AppColors.darkGreyColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              holidayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              holidayTextStyle: TextStyle(color: Colors.grey[700]),
              selectedTextStyle: const TextStyle(color: Colors.black),
              defaultTextStyle: TextStyle(color: _theme.accentColor),
              outsideTextStyle: TextStyle(color: _theme.accentColor),
              isTodayHighlighted: false),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: _theme.textTheme.subtitle1!,
          ),
          firstDay: kFirstDay,
          lastDay: kLastDay,
          daysOfWeekHeight: 50,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          availableGestures: AvailableGestures.horizontalSwipe,
          holidayPredicate: (day) {
            return holidays.contains(DateFormat('y-MM-dd').format(day));
          },
          enabledDayPredicate: (day) {
            return !holidays.contains(DateFormat('y-MM-dd').format(day));
          },
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.
            return isSameDay(_selectedDay, day) &&
                !holidays.contains(DateFormat('y-MM-dd').format(day));
            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay) &&
                !holidays.contains(DateFormat('y-MM-dd').format(selectedDay))) {
              // Call `setState()` when updating the selected day
              if (_selectedBranch == null) {
                CustomToast().buildErrorMessage(
                    context, _translator.translate("choose_branche_first")!);
              } else {
                setState(() {
                  _selectedDay = selectedDay;
                  _selectedtime = null;
                  _selecteOrderdDay = workDays
                      .where((element) =>
                          element.date ==
                          DateFormat('y-MM-dd').format(selectedDay))
                      .first;
                  _focusedDay = focusedDay;
                });
              }
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
      ],
    );
  }

  ShimmerEffect buildCalendarLoading(
      AppLocalizations _translator, ThemeData _theme) {
    return ShimmerEffect(
      child: Column(
        children: [
          SubTitle(text: _translator.translate("pick_day")),
          TableCalendar(
            calendarStyle: CalendarStyle(
                disabledTextStyle: const TextStyle(color: Colors.grey),
                todayDecoration: BoxDecoration(
                  color: AppColors.darkGreyColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.black),
                defaultTextStyle: TextStyle(color: _theme.accentColor),
                isTodayHighlighted: false),
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            daysOfWeekHeight: 50,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
          ),
        ],
      ),
    );
  }

  Widget buildEmployeesLoading(
      AppLocalizations _translator, Size _size, ThemeData _theme) {
    return ShimmerEffect(
        child: Column(
      children: [
        SubTitle(text: _translator.translate("staff")),
        SizedBox(
          height: 100,
          child: ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              separatorBuilder: (_, i) => const HorizontalGap(
                    width: defaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) => const SpecialistCard()),
        ),
      ],
    ));
  }

  Column buildEmployeesData(AppLocalizations _translator, Size _size,
      ThemeData _theme, List<CompanyEmployee> employees) {
    return Column(
      children: [
        SubTitle(text: _translator.translate("staff")),
        SizedBox(
          height: 100,
          child: ListView.separated(
              itemCount: employees.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              separatorBuilder: (_, i) => const HorizontalGap(
                    width: defaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) => SpecialistCard(
                    companyEmployee: employees[i],
                    isSelected: _selectedEmployee == employees[i].employeeId,
                    selectable: true,
                    onPressed: () {
                      if (_selectedBranch == null) {
                        CustomToast().buildErrorMessage(context,
                            _translator.translate("choose_branche_first")!);
                      } else {
                        setState(() {
                          _selectedEmployee = employees[i].employeeId;
                        });
                      }
                    },
                  )),
        ),
      ],
    );
  }
}

//bottom Booking Fixed Button
class BottomBookingButton extends StatelessWidget {
  const BottomBookingButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              // ignore: deprecated_member_use
              child: RaisedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate("confirm")!,
                  style: Theme.of(context).textTheme.button,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class TimeSelectableCard extends StatelessWidget {
  const TimeSelectableCard({
    Key? key,
    this.onTap,
    required this.isSelected,
    this.workingHour,
  }) : super(key: key);

  final VoidCallback? onTap;
  final bool? isSelected;
  final String? workingHour;
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Material(
      color: _theme.scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: 70,
          decoration: BoxDecoration(
              color: isSelected!
                  ? AppColors.primaryColor
                  : _theme.scaffoldBackgroundColor,
              border: Border.all(color: _theme.accentColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: workingHour != null
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: getTimePeriods(workingHour)
                          .format(context)
                          .split(' ')[0],
                      style: _theme.textTheme.subtitle2!.copyWith(
                          color: isSelected!
                              ? Colors.black
                              : _theme.textTheme.subtitle2!.color),
                      children: <TextSpan>[
                        const TextSpan(
                            text: '\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: getTimePeriods(workingHour)
                                .format(context)
                                .split(' ')[1]),
                      ],
                    ))
                : Container(),
          ),
        ),
      ),
    );
  }

  TimeOfDay getTimePeriods(String? time) {
    final TimeOfDay interval = TimeOfDay(
        hour: int.parse(time.toString().split(":")[0]),
        minute: int.parse(time.toString().split(":")[1]));

    return interval;
  }
}

class PriceRange {
  String? totalOrderFrom;
  String? totalOrderTo;

  PriceRange({this.totalOrderFrom, this.totalOrderTo});

  PriceRange.fromJson(Map<String, dynamic> json) {
    totalOrderFrom = json['totalOrderFrom'] as String;
    totalOrderTo = json['totalOrderTo'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalOrderFrom'] = totalOrderFrom;
    data['totalOrderTo'] = totalOrderTo;
    return data;
  }
}
