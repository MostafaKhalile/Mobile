import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Screens/Client/branchProfile/branchProfile.dart';

import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/widgets/client/branch_card.dart';

class CompanyBranchesScreen extends StatelessWidget {
  final List<CompanyBranches> companyBranches;
  const CompanyBranchesScreen({
    Key key,
    @required this.companyBranches,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: EdgeInsets.all(
            20,
          ),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: companyBranches.length,
          itemBuilder: (_, i) {
            var brancheData = companyBranches[i];
            return BranchCard(
              isSelectable: false,
              title: brancheData.brancheName,
              address: brancheData.branchAddressAR,
              rating: 4.8,
              image: KAPIURL + brancheData.image,
              onPressed: () => Navigator.pushNamed(
                  context, BranchProfile.routeName,
                  arguments: companyBranches[i]),
            );
          }),
    );
  }
}
// Container(
//             width: double.infinity,
//             child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       BranchAddressContainer(),
//                       BranchWorkingHours(),
//                       Container(
//                           width: _size.width,
//                           child: Card(
//                               elevation: 10,
//                               child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: KDefaultPadding, horizontal: 5),
//                                   child: Wrap(children: [
//                                     InfoCardHeader(
//                                       title: _translator.translate("staff"),
//                                       icon: Icons.person_outline,
//                                     ),
//                                     GridView.count(
//                                       shrinkWrap: true,
//                                       physics: BouncingScrollPhysics(),
//                                       padding: EdgeInsets.all(KDefaultPadding),
//                                       crossAxisCount: 3,
//                                       children: <Widget>[
//                                         EmployeeCard(),
//                                         EmployeeCard(),
//                                         EmployeeCard(),
//                                         EmployeeCard(),
//                                         EmployeeCard(),
//                                       ],
//                                     ),
//                                   ]))))
//                     ],
//                   ),
//                 ))))
