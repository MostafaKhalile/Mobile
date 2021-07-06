import 'package:flutter/material.dart';
import 'package:techtime/Widgets/client/order_card.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

final items = List<String>.generate(3, (i) => "Item ${i + 1}");

class PreviousAppointments extends StatefulWidget {
  @override
  _PreviousAppointmentsState createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return const PreviousAppointmentCard();
        },
      ),
    );
  }
}

class PreviousAppointmentCard extends StatelessWidget {
  const PreviousAppointmentCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: OrderCard(
            statusCode: 22,
          ),
        ),
        VerticalGap(),
      ],
    );
  }
}
