part of 'filtercompanyoffers_bloc.dart';

abstract class FiltercompanyoffersState extends Equatable {
  const FiltercompanyoffersState();

  @override
  List<Object> get props => [];
}

class FiltercompanyoffersInitial extends FiltercompanyoffersState {}

class FiltercompanyoffersLoading extends FiltercompanyoffersState {}

class FiltercompanyoffersSuccess extends FiltercompanyoffersState {
  final CompanyOffers companyOffers;

  const FiltercompanyoffersSuccess(this.companyOffers);
}

class FiltercompanyoffersFailed extends FiltercompanyoffersState {
  final String message;

  const FiltercompanyoffersFailed(this.message);
}
