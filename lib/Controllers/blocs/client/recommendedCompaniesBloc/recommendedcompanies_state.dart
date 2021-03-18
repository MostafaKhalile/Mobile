part of 'recommendedcompanies_bloc.dart';

abstract class RecommendedcompaniesState extends Equatable {
  const RecommendedcompaniesState();

  @override
  List<Object> get props => [];
}

class RecommendedcompaniesInitial extends RecommendedcompaniesState {}

class RecommendedcompaniesLoading extends RecommendedcompaniesState {
  RecommendedcompaniesLoading();
}

class RecommendedcompaniesLoaded extends RecommendedcompaniesState {
  final List<Company> recommendedCompanies;
  RecommendedcompaniesLoaded(this.recommendedCompanies);
}

class RecommendedcompaniesError extends RecommendedcompaniesState {
  final String message;
  RecommendedcompaniesError(this.message);
}
