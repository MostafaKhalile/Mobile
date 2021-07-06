part of 'branchereviews_bloc.dart';

abstract class BranchereviewsEvent extends Equatable {
  const BranchereviewsEvent();

  @override
  List<Object> get props => [];
}

class GetBrancheReviews extends BranchereviewsEvent {
  final int branchId;

  const GetBrancheReviews(this.branchId);
}
