part of 'branchereviews_bloc.dart';

abstract class BranchereviewsState extends Equatable {
  const BranchereviewsState();

  @override
  List<Object> get props => [];
}

class BranchereviewsInitial extends BranchereviewsState {}

class BrancheReviewsLoading extends BranchereviewsState {}

class BrancheReviewsSuccess extends BranchereviewsState {
  final BrancheReviews reviews;

  const BrancheReviewsSuccess(this.reviews);
}

class BrancheReviewsFaild extends BranchereviewsState {
  final String message;

  const BrancheReviewsFaild(this.message);
}
