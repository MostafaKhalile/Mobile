part of 'companieslist_bloc.dart';

abstract class CompanieslistEvent extends Equatable {
  const CompanieslistEvent();

  @override
  List<Object> get props => [];
}

class GetCompaniesList extends CompanieslistEvent {
  final int id;
  GetCompaniesList(this.id);
}
