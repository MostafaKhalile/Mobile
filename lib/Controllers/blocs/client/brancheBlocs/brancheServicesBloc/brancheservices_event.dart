part of 'brancheservices_bloc.dart';

abstract class BrancheservicesEvent extends Equatable {
  const BrancheservicesEvent();

  @override
  List<Object> get props => [];
}

class GetBrancheservices extends BrancheservicesEvent {
  final int branchId;

  GetBrancheservices(this.branchId);
}
