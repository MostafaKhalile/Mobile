import 'package:techtime/Controllers/Repositories/reservations/reservations_repository.dart';
import 'package:techtime/Models/Params/create_order_first_step_params.dart';
import 'package:techtime/Models/reservations/create_new_order_response.dart';

abstract class ReservationController {
  Future createNewOrder(int id, CreateOrderFirstStepParams params);
  Future<bool> createNewOrderSecondStep(List items);
}

class ServicesReservation extends ReservationController {
  final ReservationsRepo _reservationsRepo = ReservationsRepo();

  @override
  Future<CreateNewOrderResponse> createNewOrder(
      int branchId, CreateOrderFirstStepParams params) {
    return _reservationsRepo.createNewOrder(branchId, params);
  }

  @override
  Future<bool> createNewOrderSecondStep(List items) {
    // TODO: implement createNewOrderSecondStep
    throw UnimplementedError();
  }
}

class OfferReservation extends ReservationController {
  @override
  Future<bool> createNewOrder(int branchId, CreateOrderFirstStepParams params) {
    // TODO: implement createNewOrder
    throw UnimplementedError();
  }

  @override
  Future<bool> createNewOrderSecondStep(List items) {
    // TODO: implement createNewOrderSecondStep
    throw UnimplementedError();
  }
}
