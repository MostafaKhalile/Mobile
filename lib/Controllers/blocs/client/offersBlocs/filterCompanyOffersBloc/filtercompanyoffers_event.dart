part of 'filtercompanyoffers_bloc.dart';

abstract class FiltercompanyoffersEvent extends Equatable {
  const FiltercompanyoffersEvent();

  @override
  List<Object> get props => [];
}

class FilterCompanyOffers extends FiltercompanyoffersEvent {
  final int? id;

  const FilterCompanyOffers(this.id);
}
