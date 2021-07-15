import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/favoritesBloc/favorites_bloc.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/branche.dart';
import 'package:techtime/Screens/Client/branchProfile/branch_profile.dart';
import 'package:techtime/Widgets/client/branch_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';

class FavoriteBranches extends StatefulWidget {
  const FavoriteBranches({Key key}) : super(key: key);

  @override
  _FavoriteBranchesState createState() => _FavoriteBranchesState();
}

class _FavoriteBranchesState extends State<FavoriteBranches> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(GetFavoriteBranches());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
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
        } else {
          widget = const BranchesShimmer();
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

class BranchesShimmer extends StatelessWidget {
  const BranchesShimmer({
    Key key,
    this.branches,
  }) : super(key: key);
  final List<BrancheData> branches;
  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: ListView.builder(
          padding: const EdgeInsets.all(
            20,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (_, i) {
            return BranchCard(
              isSelectable: false,
              title: "",
              address: "",
              rating: 4.8,
              onPressed: () => Navigator.pushNamed(
                  context, BranchProfile.routeName,
                  arguments: branches[i]),
            );
          }),
    );
  }
}
