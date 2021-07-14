import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:http/http.dart' as http;
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
}
