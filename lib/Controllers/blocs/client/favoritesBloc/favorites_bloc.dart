import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/favorites/repository.dart';
import 'package:techtime/Models/client/branche.dart';
import 'package:techtime/Models/client/company.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._favoritesRepo) : super(FavoritesInitial());
  final FavoritesRepo _favoritesRepo;

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is GetFavoriteCompanies) {
      yield FavoritesCompaniesLoading();
      final companies = await _favoritesRepo.getUserfavoriteCompanies();
      yield FavoritesCompaniessuccess(companies);
      try {} catch (e) {
        yield FavoritesCompaniesFailed(e.toString());
      }
    }
    if (event is GetFavoriteBranches) {
      yield FavoritesBranchesLoading();
      final branches = await _favoritesRepo.getUserfavoriteBranches();
      yield FavoritesBranchesSuccess(branches);
      try {} catch (e) {
        yield FavoritesBranchesFailed(e.toString());
      }
    }
  }
}
