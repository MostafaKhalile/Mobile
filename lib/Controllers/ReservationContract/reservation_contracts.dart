abstract class ReservationController {
  Future<bool> createNewOrder();
  Future<bool> createNewOrderSecondStep(List items);
  bool isCustomized;
}

class ServicesReservation extends ReservationController {
  @override
  Future<bool> createNewOrder() {
    // TODO: implement createNewOrder
    throw UnimplementedError();
  }

  @override
  Future<bool> createNewOrderSecondStep(List items) {
    // TODO: implement createNewOrderSecondStep
    throw UnimplementedError();
  }
}
