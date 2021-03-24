part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  const CompanyProfileEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyProfile extends CompanyProfileEvent {
  final int id;
  GetCompanyProfile(this.id);
}
