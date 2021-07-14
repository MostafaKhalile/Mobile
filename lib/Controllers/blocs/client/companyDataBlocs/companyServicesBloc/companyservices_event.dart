part of 'companyservices_bloc.dart';

abstract class CompanyservicesEvent extends Equatable {
  const CompanyservicesEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyServices extends CompanyservicesEvent {
  final int branchId;

  const GetCompanyServices(this.branchId);
}
