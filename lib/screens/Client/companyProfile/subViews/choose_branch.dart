import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Screens/Client/branchProfile/branch_profile.dart';
import 'package:techtime/widgets/client/branch_card.dart';

class ChooseBranch extends StatelessWidget {
  static const String routeName = "/choose_branch";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("تتوفر هذه الخدمات فى الفروع التالية",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black)),
          automaticallyImplyLeading: false,
          excludeHeaderSemantics: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: <Widget>[
              Column(
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (_, i) => BranchCard(
                            isSelectable: false,
                            title: "اسم الفرع",
                            address: "شارع 33, منطقة ميامي, الإسكندرية",
                            rating: 4.8,
                            image: placeHolderImage,
                            onPressed: () => Navigator.pushNamed(
                                context, BranchProfile.routeName),
                          )),
                ],
              )
            ])));
  }
}
