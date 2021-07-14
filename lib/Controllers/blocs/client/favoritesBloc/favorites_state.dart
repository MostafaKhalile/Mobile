part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesCompaniesLoading extends FavoritesState {}

class FavoritesCompaniessuccess extends FavoritesState {
  final List<Company> companies;

  const FavoritesCompaniessuccess(this.companies);
}

class FavoritesCompaniesFailed extends FavoritesState {
  final String message;

  const FavoritesCompaniesFailed(this.message);
}

class FavoritesBranchesLoading extends FavoritesState {}

class FavoritesBranchesSuccess extends FavoritesState {
  final List<BrancheData> branches;

  const FavoritesBranchesSuccess(this.branches);
}

class FavoritesBranchesFailed extends FavoritesState {
  final String message;

  const FavoritesBranchesFailed(this.message);
}
