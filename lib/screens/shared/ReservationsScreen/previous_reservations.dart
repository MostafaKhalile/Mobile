import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/reservations/reservations_bloc.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Widgets/client/guest_access_denied.dart';
import 'package:techtime/Widgets/core/reservation_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class PreviousReservations extends StatefulWidget {
  @override
  _PreviousReservationsState createState() => _PreviousReservationsState();
}

class _PreviousReservationsState extends State<PreviousReservations> {
  UserProfile? currentUser;
  @override
  void initState() {
    final reservations = BlocProvider.of<ReservationsBloc>(context);

    reservations.add(GetPreviousResrvations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    return Scaffold(
        body: (currentUser != null)
            ? BlocBuilder<ReservationsBloc, ReservationsState>(
                builder: (context, state) {
                  Widget widget;
                  if (state is PreviousReservationsSuccess) {
                    if (state.reservations!.isNotEmpty) {
                      widget = ListView.separated(
                        itemCount: state.reservations!.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (_, i) => const VerticalGap(),
                        itemBuilder: (context, index) {
                          return ReservationCard(
                            statusCode: 22,
                            reservation: state.reservations![index],
                          );
                        },
                      );
                    } else {
                      widget = const Center(
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
                  }
                  return widget;
                },
              )
            : const Center(
                child: GuestUserAccessDeniedScreen(),
              ));
  }
}
