import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/client/branch_card.dart';

class BranchInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AppLocalizations _translator = AppLocalizations.of(context);
    // Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (_, i) => BranchCard(
                title: "اسم الفرع",
                description: "تقديم خدمات لكافة الأغراض",
                address: "شارع 33, منطقة ميامي, الإسكندرية",
                rating: 4.8,
                image: KPlaceHolderImage,
                onPressed: () {},
              )),
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
