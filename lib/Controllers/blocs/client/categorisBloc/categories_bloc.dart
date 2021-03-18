import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:techtime/Controllers/repositories/client/user_home_repo.dart';
import 'package:techtime/models/client/category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final APIClientHomeRepository _apiClientRepository;
  CategoriesBloc(this._apiClientRepository) : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is GetCatgories) {
      try {
        yield CategoriesLoading();
        final categories = await _apiClientRepository.fetchCategories;
        yield CategoriesLoaded(categories);
      } catch (e) {
        yield CategoriesError(e.toString());
      }
    }
  }
}
