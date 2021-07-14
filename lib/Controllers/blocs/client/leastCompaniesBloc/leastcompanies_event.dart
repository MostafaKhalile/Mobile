part of 'leastcompanies_bloc.dart';

abstract class LeastcompaniesEvent extends Equatable {
  const LeastcompaniesEvent();

  @override
  List<Object> get props => [];
}

class GetLeastCompanies extends LeastcompaniesEvent {
  const GetLeastCompanies();
}
