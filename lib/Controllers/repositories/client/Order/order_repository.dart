import 'package:techtime/Models/client/orders/order_date_time.dart';

import 'order_api_client.dart';

class OrdersRepository {
  OrdersApiClient _ordersApiClient = OrdersApiClient();
  Future<List<OrderDateTime>> getOrderDateTime(int brancheId) async {
    try {
      final dataResp = await _ordersApiClient.getOrderDateTime(brancheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
