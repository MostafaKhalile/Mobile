import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/branchEmployeesBloc/brancheemployees_bloc.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client/brancheData/company_employee.dart';
import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/widgets/client/branch_card.dart';
import 'package:intl/intl.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class CreateNewOrder extends StatefulWidget {
  static const String routeName = "/create_new_order";
  final List<CompanyBranches> companyBranches;

  const CreateNewOrder({Key key, this.companyBranches}) : super(key: key);

  @override
  _CreateNewOrderState createState() => _CreateNewOrderState();
}

class _CreateNewOrderState extends State<CreateNewOrder> {
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
              BookingBody(companyBranches: widget.companyBranches)
            ])),
        persistentFooterButtons: [
          BottomBookingButton(
            onPressed: () {
              print("Booking");
            },
          )
        ]);
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

//Branch Profile Body White Section Below
class BookingBody extends StatefulWidget {
  final List<CompanyBranches> companyBranches;

  const BookingBody({
    Key key,
    this.companyBranches,
  }) : super(key: key);

  @override
  _BookingBodyState createState() => _BookingBodyState();
}

class _BookingBodyState extends State<BookingBody> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  int _selectedBranch;
  int _selectedtime;
  int _selectedEmployee;
  @override
  void initState() {
    BlocProvider.of<BrancheemployeesBloc>(context)
        .add(GetBrancheEmployees(widget.companyBranches[0].brancheID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    return Expanded(
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
                        SubTitle(text: _translator.translate("choose_branche")),
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KDefaultPadding),
                              itemCount: widget.companyBranches.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (_, i) => HorizontalGap(),
                              itemBuilder: (_, i) {
                                var brancheData = widget.companyBranches[i];
                                return BranchCard(
                                  isSelectable: true,
                                  isSelected:
                                      brancheData.brancheID == _selectedBranch,
                                  title: brancheData.brancheName,
                                  address: brancheData.branchAddressAR,
                                  rating: 4.8,
                                  image: KAPIURL + brancheData.image,
                                  onPressed: () {
                                    BlocProvider.of<BrancheemployeesBloc>(
                                            context)
                                        .add(GetBrancheEmployees(
                                            brancheData.brancheID));
                                    setState(() {
                                      _selectedBranch = brancheData.brancheID;
                                    });
                                  },
                                );
                              }),
                        ),
                        VerticalGap(
                          height: KDefaultPadding / 2,
                        ),
                        Column(
                          children: [
                            SubTitle(text: _translator.translate("pick_day")),
                            TableCalendar(
                              calendarStyle: CalendarStyle(
                                  disabledTextStyle:
                                      TextStyle(color: Colors.grey),
                                  todayDecoration: BoxDecoration(
                                    color: KDarkGreyColor.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: KPrimaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  selectedTextStyle:
                                      TextStyle(color: Colors.black),
                                  defaultTextStyle:
                                      TextStyle(color: _theme.accentColor),
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
                              selectedDayPredicate: (day) {
                                // Use `selectedDayPredicate` to determine which day is currently selected.
                                // If this returns true, then `day` will be marked as selected.

                                // Using `isSameDay` is recommended to disregard
                                // the time-part of compared DateTime objects.

                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  // Call `setState()` when updating the selected day
                                  print(
                                      "Selected Day is ${DateFormat('EEEE').format(selectedDay)}");
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                }
                              },
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  // Call `setState()` when updating calendar format
                                  setState(() {
                                    _calendarFormat = format;
                                  });
                                }
                              },
                              onPageChanged: (focusedDay) {
                                // No need to call `setState()` here
                                _focusedDay = focusedDay;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //build Branch Previous work data
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

                  //choose Branch specialists
                  BlocBuilder<BrancheemployeesBloc, BrancheemployeesState>(
                    builder: (context, state) {
                      if (state is BrancheemployeesSuccess) {
                        if (state.employees.length > 0) {
                          return buildEmployeesData(
                              _translator, _size, _theme, state.employees);
                        } else {
                          return Container();
                        }
                      }
                      return buildEmployeesLoading(_translator, _size, _theme);
                    },
                  ),
                ],
              ),
            )));
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
                    isSelected: _selectedEmployee == i,
                    selectable: true,
                    onPressed: () {
                      setState(() {
                        _selectedEmployee = i;
                      });
                    },
                  )),
        ),
      ],
    );
  }
}

class TimeSelectableCard extends StatelessWidget {
  const TimeSelectableCard({
    Key key,
    this.onTap,
    @required this.isSelected,
  }) : super(key: key);

  final Function onTap;
  final bool isSelected;
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
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '11:00 ',
                style: _theme.textTheme.subtitle2.copyWith(
                    color: isSelected ?? false
                        ? Colors.black
                        : _theme.textTheme.subtitle2.color),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'AM'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
          VerticalGap(),
          Row(
            children: [
              Text(
                text,
                style: _theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          VerticalGap(),
        ],
      ),
    );
  }
}
