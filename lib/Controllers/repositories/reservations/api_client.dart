import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/Models/reservations/create_new_order_response.dart';
import 'package:techtime/Models/reservations/find_branch_response.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';
import 'package:techtime/Models/reservations/reservations_respone.dart';

class ReservationsApiClient {
  // final AuthRepo _authRepo = AuthRepo();
  final headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json",
    "Authorization": "Token ${AuthRepo().currentUserToken}"
  };

  Future<ReservationsRespone> getPreviousReservations() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.previousReservations;
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;

      return ReservationsRespone.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)['message']}');
    }
  }

  Future<ReservationsRespone> getUpcomingReservations() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.upcomingReservations;
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;

      return ReservationsRespone.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)['message']}');
    }
  }

  Future<ReservationDetails> getReservationDetails(int reservationId) async {
    final String path =
        "${NetworkConstants.baseUrl}${NetworkConstants.reservationDetails}$reservationId";
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)["DetailsOrder"] as Map<String, dynamic>;
      return ReservationDetails.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)['message']}');
    }
  }

  Future<FindBranchResponse> findBranchForReservation(
      Map<String, String> params) async {
    final String path =
        "${NetworkConstants.baseUrl}${NetworkConstants.findBranchForOrder}";
    final request = http.MultipartRequest('POST', Uri.parse(path));
    request.fields.addAll(params);
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print(response);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;
      return FindBranchResponse.fromJson(data);
    } else {
      print('${json.decode(response.body)['message']}');
      throw Future.error('${json.decode(response.body)['message']}');
    }
  }

  Future<CreateNewOrderResponse> createNewOrder(int branchId) async {
    final String path =
        "${NetworkConstants.baseUrl}${NetworkConstants.createNewOrder}$branchId";
    final response = await http.post(Uri.parse(path), headers: headers);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;
      return CreateNewOrderResponse.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)['message']}');
    }
  }
}
