part of 'companyoffers_bloc.dart';

abstract class CompanyoffersState extends Equatable {
  const CompanyoffersState();

  @override
  List<Object> get props => [];
}

class CompanyoffersInitial extends CompanyoffersState {}

class CompanyoffersLoading extends CompanyoffersState {}

class CompanyoffersSuccess extends CompanyoffersState {
  final List<CompanyDataOffer> companyOffers;

  const CompanyoffersSuccess(this.companyOffers);
}

class CompanyoffersFaild extends CompanyoffersState {
  final String message;

  const CompanyoffersFaild(this.message);
}
