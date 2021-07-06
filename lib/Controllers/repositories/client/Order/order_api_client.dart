import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Helpers/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/orders/order_date_time.dart';

class OrdersApiClient {
  AuthRepo authRepo = AuthRepo();

  Future<List<OrderDateTime>> getOrderDateTime(int id) async {
    final String path =
        KAPIURL + NetworkConstants.orderDateTime + id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${authRepo.currentUserToken}"
    });
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as List;
      return data.map((rawPost) {
        return OrderDateTime.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }
}
