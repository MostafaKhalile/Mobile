import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/branchEmployeesBloc/brancheemployees_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/orderBlocs/orderDateTimeBloc/orderdatetime_bloc.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/Models/client/orders/order_date_time.dart';
import 'package:techtime/Screens/Client/booking/bookingTable/table_reservation.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/widgets/client/branch_card.dart';
import 'package:intl/intl.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class OrderFirstStep extends StatefulWidget {
  static const String routeName = "/order_first_step";
  final List<CompanyBranche> companyBranches;

  const OrderFirstStep({Key key, this.companyBranches}) : super(key: key);

  @override
  _OrderFirstStepState createState() => _OrderFirstStepState();
}

class _OrderFirstStepState extends State<OrderFirstStep> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  OrderDateTime _selecteOrderdDay;
  String _selecteOrderTime;
  List<String> holidays = [];
  List<String> availableTimes = [];

  int _selectedBranch;
  int _selectedtime;
  int _selectedEmployee;
  Locale locale;
  @override
  void initState() {
    BlocProvider.of<BrancheemployeesBloc>(context)
        .add(GetBrancheEmployees(widget.companyBranches[0].brancheID));
    BlocProvider.of<OrderDateTimeBloc>(context)
      ..add(GetOrderDateTimes(widget.companyBranches[0].brancheID));
    locale = BlocProvider.of<LocaleCubit>(context).state.locale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _translator.translate("book_appointment"),
            style: _theme.textTheme.headline6.copyWith(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SizedBox(
            width: _size.width,
            height: _size.height,
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: KDefaultPadding),
                              child: Column(
                                children: [
                                  SubTitle(
                                      text: _translator
                                          .translate("choose_branche")),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: KDefaultPadding),
                                        itemCount:
                                            widget.companyBranches.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder: (_, i) =>
                                            HorizontalGap(),
                                        itemBuilder: (_, i) {
                                          var brancheData =
                                              widget.companyBranches[i];
                                          return BranchCard(
                                            isSelectable: true,
                                            isSelected: brancheData.brancheID ==
                                                _selectedBranch,
                                            title: brancheData.brancheName,
                                            address:
                                                brancheData.branchAddressAR,
                                            rating: 4.8,
                                            image: KAPIURL + brancheData.image,
                                            onPressed: () {
                                              BlocProvider.of<
                                                          BrancheemployeesBloc>(
                                                      context)
                                                  .add(GetBrancheEmployees(
                                                      brancheData.brancheID));
                                              BlocProvider.of<
                                                          OrderDateTimeBloc>(
                                                      context)
                                                  .add(GetOrderDateTimes(
                                                      brancheData.brancheID));
                                              setState(() {
                                                _selectedBranch =
                                                    brancheData.brancheID;
                                                _selecteOrderdDay = null;
                                                _selecteOrderTime = null;
                                                _selectedDay = null;
                                                _selectedEmployee = null;
                                              });
                                            },
                                          );
                                        }),
                                  ),
                                  VerticalGap(
                                    height: KDefaultPadding / 2,
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
                                              itemCount: _selecteOrderdDay
                                                  .orderTimes.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics: BouncingScrollPhysics(),
                                              separatorBuilder: (_, i) =>
                                                  HorizontalGap(),
                                              itemBuilder: (ctx, i) =>
                                                  TimeSelectableCard(
                                                    isSelected:
                                                        i == _selectedtime,
                                                    workingHour:
                                                        _selecteOrderdDay
                                                            .orderTimes[i],
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedtime = i;
                                                        _selecteOrderTime =
                                                            _selecteOrderdDay
                                                                .orderTimes[i];
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
                                  if (state.employees.length > 0) {
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
          BottomBookingButton(
            onPressed: () {
              bool isValid = _validateBooking();
              // Navigator.pushNamed(context, TableReservation.routeName);
              print("Booking $isValid ");
            },
          )
        ]);
  }

  _validateBooking() {
    return (_selecteOrderTime != null &&
        _selecteOrderdDay != null &&
        _selectedEmployee != null &&
        _selectedBranch != null);
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
                physics: BouncingScrollPhysics(),
                separatorBuilder: (_, i) => HorizontalGap(),
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
            List<String> tempDays = [];
            workDays.forEach((day) {
              if (day.open == false) tempDays.add(day.date);
            });
            holidays = tempDays;
            print(holidays);
          },
          weekendDays: [],
          calendarStyle: CalendarStyle(
              disabledTextStyle: TextStyle(color: Colors.grey[700]),
              todayDecoration: BoxDecoration(
                color: KDarkGreyColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: KPrimaryColor,
                shape: BoxShape.circle,
              ),
              holidayDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              holidayTextStyle: TextStyle(color: Colors.grey[700]),
              selectedTextStyle: TextStyle(color: Colors.black),
              defaultTextStyle: TextStyle(color: _theme.accentColor),
              outsideTextStyle: TextStyle(color: _theme.accentColor),
              isTodayHighlighted: false),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: _theme.textTheme.subtitle1,
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
            return (isSameDay(_selectedDay, day) &&
                !holidays.contains(DateFormat('y-MM-dd').format(day)));
            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay) &&
                !holidays.contains(DateFormat('y-MM-dd').format(selectedDay))) {
              // Call `setState()` when updating the selected day
              if (_selectedBranch == null) {
                CustomToast().buildErrorMessage(
                    context, _translator.translate("choose_branche_first"));
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
                disabledTextStyle: TextStyle(color: Colors.grey),
                todayDecoration: BoxDecoration(
                  color: KDarkGreyColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.black),
                defaultTextStyle: TextStyle(color: _theme.accentColor),
                isTodayHighlighted: false),
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
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
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: KDefaultPadding / 2),
              separatorBuilder: (_, i) => HorizontalGap(
                    width: KDefaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) => SpecialistCard()),
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
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: KDefaultPadding / 2),
              separatorBuilder: (_, i) => HorizontalGap(
                    width: KDefaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) => SpecialistCard(
                    companyEmployee: employees[i],
                    isSelected: _selectedEmployee == employees[i].employeeId,
                    selectable: true,
                    onPressed: () {
                      if (_selectedBranch == null) {
                        CustomToast().buildErrorMessage(context,
                            _translator.translate("choose_branche_first"));
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
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  AppLocalizations.of(context).translate("confirm"),
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
    Key key,
    this.onTap,
    @required this.isSelected,
    this.workingHour,
  }) : super(key: key);

  final Function onTap;
  final bool isSelected;
  final String workingHour;
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Material(
      color: _theme.scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: 70,
          decoration: BoxDecoration(
              color: isSelected ?? false
                  ? KPrimaryColor
                  : _theme.scaffoldBackgroundColor,
              border: Border.all(width: 1, color: _theme.accentColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: workingHour != null
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: getTimePeriods(workingHour)
                          .format(context)
                          .split(' ')[0],
                      style: _theme.textTheme.subtitle2.copyWith(
                          color: isSelected ?? false
                              ? Colors.black
                              : _theme.textTheme.subtitle2.color),
                      children: <TextSpan>[
                        TextSpan(
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

  TimeOfDay getTimePeriods(String time) {
    TimeOfDay interval = TimeOfDay(
        hour: int.parse(time.toString().split(":")[0]),
        minute: int.parse(time.toString().split(":")[1]));

    return interval;
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: KDefaultPadding),
      child: Column(
        children: [
          VerticalGap(
            height: KdefaultPadding / 2,
          ),
          Row(
            children: [
              Text(
                text,
                style: _theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          VerticalGap(
            height: KdefaultPadding / 2,
          ),
        ],
      ),
    );
  }
}
