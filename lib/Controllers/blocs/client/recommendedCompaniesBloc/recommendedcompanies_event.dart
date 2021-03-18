part of 'recommendedcompanies_bloc.dart';

abstract class RecommendedcompaniesEvent extends Equatable {
  const RecommendedcompaniesEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendedCompnies extends RecommendedcompaniesEvent {
  GetRecommendedCompnies();
}
