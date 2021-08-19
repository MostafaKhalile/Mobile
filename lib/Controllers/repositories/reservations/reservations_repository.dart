import 'dart:async';

import 'package:techtime/Models/Params/create_order_first_step_params.dart';
import 'package:techtime/Models/reservations/create_new_order_response.dart';
import 'package:techtime/Models/reservations/find_branch_response.dart';
import 'package:techtime/Models/reservations/reservation.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';

import 'api_client.dart';

class ReservationsRepo {
  final ReservationsApiClient _apiClient = ReservationsApiClient();

  Future<List<Reservation>?> getPreviousReservations() async {
    final historyReservations = await _apiClient.getPreviousReservations();
    return historyReservations.listReservations;
  }

  Future<List<Reservation>?> getUpcomingReservations() async {
    final upcomingReservations = await _apiClient.getUpcomingReservations();
    return upcomingReservations.listReservations;
  }

  Future<ReservationDetails> getReservationDetails(int? reservationId) async {
    final reservationDetails =
        await _apiClient.getReservationDetails(reservationId);
    return reservationDetails;
  }

  Future<FindBranchResponse> findBranchForReservation(
      Map<String, String> params) async {
    final response = await _apiClient.findBranchForReservation(params);
    return response;
  }

  Future<CreateNewOrderResponse> createNewOrder(
      int branchId, CreateOrderFirstStepParams params) async {
    final response = await _apiClient.createNewOrder(branchId, params);
    return response;
  }

  Future<bool> createServicesOrderSecondStep(int orderId, List services) async {
    final response =
        await _apiClient.createServicesOrderSecondStep(orderId, services);
    return response;
  }
}
