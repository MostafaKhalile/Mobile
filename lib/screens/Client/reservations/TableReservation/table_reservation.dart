import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:intl/intl.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class TableReservation extends StatefulWidget {
  static const String routeName = "/table_reservation";
  const TableReservation({Key? key}) : super(key: key);

  @override
  _TableReservationState createState() => _TableReservationState();
}

class _TableReservationState extends State<TableReservation> {
  int counter = 0;
  TextEditingController dateCtl = TextEditingController();
  TextEditingController noteCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    final ThemeData _theme = Theme.of(context);
    String? dropdownValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _translator.translate("book_your_table")!,
          style: _theme.textTheme.headline6!.copyWith(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _translator.translate("seats_no")!,
                  style: _theme.textTheme.caption,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (counter > 0) {
                            counter--;
                          }
                        });
                      },
                      color: Colors.redAccent.withOpacity(0.8),
                    ),
                    const HorizontalGap(),
                    Text(
                      counter.toString(),
                      style: _theme.textTheme.headline6,
                    ),
                    const HorizontalGap(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.greenAccent.withOpacity(0.8),
                      onPressed: () {
                        setState(() {
                          counter++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: dateCtl,
              decoration: InputDecoration(
                labelText: _translator.translate("date&time"),
                hintText: "Ex. Insert your dob",
              ),
              onTap: () async {
                DateTime? date = DateTime(1900);
                TimeOfDay? time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(FocusNode());

                date = await (showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: kFirstDay,
                        lastDate: DateTime(kNow.year, kNow.month + 6, kNow.day))
                    as Future<DateTime>);
                time = await (showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                ) as Future<TimeOfDay>);
                dateCtl.text =
                    "${DateFormat('dd-MM-y').format(date)}\t${time.format(context)}";
              },
            ),
            const VerticalGap(),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              hint: Text(_translator.translate("select_booking_type")!),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Birth Day Booking', 'Party', 'Romantic Dinner']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const VerticalGap(),
            TextFormField(
              controller: noteCtl,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: _translator.translate("note"),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: _size.width,
          child: Row(
            children: [
              Expanded(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                padding: const EdgeInsets.all(10),
                onPressed: () => {},
                disabledColor: Colors.black38,
                child: Text(
                  _translator.translate("book_now")!,
                  style: Theme.of(context).textTheme.button,
                ),
              ))
            ],
          ),
        )
      ],
    );
  }
}
