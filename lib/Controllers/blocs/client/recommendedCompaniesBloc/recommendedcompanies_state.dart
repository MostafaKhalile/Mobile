part of 'recommendedcompanies_bloc.dart';

abstract class RecommendedcompaniesState extends Equatable {
  const RecommendedcompaniesState();

  @override
  List<Object> get props => [];
}

class RecommendedcompaniesInitial extends RecommendedcompaniesState {}

class RecommendedcompaniesLoading extends RecommendedcompaniesState {
  const RecommendedcompaniesLoading();
}

class RecommendedcompaniesLoaded extends RecommendedcompaniesState {
  final List<Company> recommendedCompanies;
  const RecommendedcompaniesLoaded(this.recommendedCompanies);
}

class RecommendedcompaniesError extends RecommendedcompaniesState {
  final String message;
  const RecommendedcompaniesError(this.message);
}
