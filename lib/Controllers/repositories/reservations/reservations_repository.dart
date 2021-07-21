import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';

import 'api_client.dart';

class ReservationsRepo {
  final ReservationsApiClient _apiClient = ReservationsApiClient();

  Future<List<Reservation>> getPreviousReservations() async {
    final historyReservations = await _apiClient.getPreviousReservations();
    return historyReservations.listReservations;
  }

  Future<List<Reservation>> getUpcomingReservations() async {
    final upcomingReservations = await _apiClient.getUpcomingReservations();
    return upcomingReservations.listReservations;
  }

  Future<ReservationDetails> getReservationDetails(int reservationId) async {
    final reservationDetails =
        await _apiClient.getReservationDetails(reservationId);
    return reservationDetails;
  }
}
