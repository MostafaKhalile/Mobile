part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class GetCatgories extends CategoriesEvent {
  GetCatgories();
}
