part of 'brancheoffers_bloc.dart';

abstract class BrancheOffersEvent extends Equatable {
  const BrancheOffersEvent();

  @override
  List<Object> get props => [];
}

class GetBrancheOffers extends BrancheOffersEvent {
  final int branchId;

  const GetBrancheOffers(this.branchId);
}
