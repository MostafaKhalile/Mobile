part of 'companyoffers_bloc.dart';

abstract class CompanyoffersEvent extends Equatable {
  const CompanyoffersEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyOffers extends CompanyoffersEvent {}
