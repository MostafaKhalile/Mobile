import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/reservations/reservations_bloc.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Widgets/client/guest_access_denied.dart';
import 'package:techtime/Widgets/core/reservation_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class UpcomingReservations extends StatefulWidget {
  @override
  UpcomingReservationsState createState() => UpcomingReservationsState();
}

class UpcomingReservationsState extends State<UpcomingReservations> {
  UserProfile? currentUser;
  @override
  void initState() {
    final reservations = BlocProvider.of<ReservationsBloc>(context);

    reservations.add(GetUpcomingResrvations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    final AppLocalizations? _translator = AppLocalizations.of(context);
    return Scaffold(
        body: (currentUser != null)
            ? BlocBuilder<ReservationsBloc, ReservationsState>(
                builder: (context, state) {
                  Widget widget;
                  if (state is UpcomingReservationsSuccess) {
                    if (state.reservations!.isNotEmpty) {
                      widget = ListView.separated(
                          itemCount: state.reservations!.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (_, i) => const VerticalGap(),
                          itemBuilder: (context, index) {
                            final item = state.reservations![index];

                            return Dismissible(
                                // Each Dismissible must contain a Key. Keys allow Flutter to
                                // uniquely identify widgets.
                                key: Key(item.toString()),
                                // Provide a function that tells the app
                                // what to do after an item has been swiped away.
                                onDismissed: (direction) {
                                  // Remove the item from the data source.
                                  buildOnDismiss(
                                      index, context, item.toString());
                                },
                                confirmDismiss: (direction) async {
                                  return buildShowDialog(context, _translator);
                                },
                                // Show a red background as the item is swiped away.
                                background: Container(
                                  color: Colors.redAccent.withOpacity(0.2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _translator!.translate("cancel")!,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: ReservationCard(
                                  statusCode: 40,
                                  reservation:
                                      state.reservations!.elementAt(index),
                                ));
                          });
                    } else {
                      return const Center(
                        child: Text("Empty State"),
                      );
                    }
                  } else {
                    widget = ShimmerEffect(
                      child: ListView.separated(
                        itemCount: 5,
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (_, i) => const VerticalGap(),
                        itemBuilder: (context, index) {
                          return const ReservationCard(
                            statusCode: 22,
                            reservation: Reservation(),
                          );
                        },
                      ),
                    );
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return widget;
                },
              )
            : const Center(
                child: GuestUserAccessDeniedScreen(),
              ));
  }

  void buildOnDismiss(int index, BuildContext context, String item) {
    // Remove the item from the data source.
    setState(() {
      // res.removeAt(index);
    });

    // Then show a snackbar.
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$item dismissed")));
  }

  Future<bool?> buildShowDialog(
      BuildContext context, AppLocalizations? _translator) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_translator!.translate("are_sure_to_cancel_appointment")!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    _translator.translate("cancel")!,
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    _translator.translate("confirm")!,
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
