import 'package:flutter/material.dart';
import 'package:techtime/Helpers/network_constants.dart';

import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/widgets/client/branch_card.dart';

import '../../branchProfile/branch_profile.dart';

class CompanyBranchesScreen extends StatelessWidget {
  final List<CompanyBranche> companyBranches;
  const CompanyBranchesScreen({
    Key key,
    @required this.companyBranches,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(
            20,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: companyBranches.length,
          itemBuilder: (_, i) {
            final brancheData = companyBranches[i];
            return BranchCard(
              isSelectable: false,
              title: brancheData.brancheName,
              address: brancheData.branchAddressAR,
              rating: 4.8,
              image: NetworkConstants.baseUrl + brancheData.image,
              onPressed: () => Navigator.pushNamed(
                  context, BranchProfile.routeName,
                  arguments: companyBranches[i]),
            );
          }),
    );
  }
}
