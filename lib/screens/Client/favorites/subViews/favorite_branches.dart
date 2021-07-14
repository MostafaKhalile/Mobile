import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/favoritesBloc/favorites_bloc.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/branche.dart';
import 'package:techtime/Screens/Client/branchProfile/branch_profile.dart';
import 'package:techtime/Widgets/client/branch_card.dart';

class FavoriteBranches extends StatelessWidget {
  const FavoriteBranches({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) {
        return current is FavoritesBranchesLoading ||
            current is FavoritesBranchesSuccess ||
            current is FavoritesBranchesFailed;
      },
      builder: (context, state) {
        Widget widget;
        if (state is FavoritesBranchesSuccess) {
          if (state.branches.isNotEmpty) {
            widget = BranchesWithData(
              branches: state.branches,
            );
          } else {
            widget = const Center(
              child: Text("Empty State"),
            );
          }
        }
        return widget;
      },
    );
  }
}

class BranchesWithData extends StatelessWidget {
  const BranchesWithData({
    Key key,
    this.branches,
  }) : super(key: key);
  final List<BrancheData> branches;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(
          20,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: branches.length,
        itemBuilder: (_, i) {
          final brancheData = branches[i];
          return BranchCard(
            isSelectable: false,
            title: brancheData.brancheName,
            address: brancheData.branchAddressAR,
            rating: 4.8,
            image: (brancheData.companyImage != null)
                ? NetworkConstants.baseUrl + brancheData.companyImage
                : null,
            onPressed: () => Navigator.pushNamed(
                context, BranchProfile.routeName,
                arguments: branches[i]),
          );
        });
  }
}
