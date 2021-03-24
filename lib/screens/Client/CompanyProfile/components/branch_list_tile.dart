import 'package:flutter/material.dart';
import 'package:techtime/models/client/companyProfile/company_branches.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class BranchListTile extends StatelessWidget {
  final Function onTap;
  final CompanyBranche branche;
  const BranchListTile({
    Key key,
    this.onTap,
    this.branche,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CustomCircleAvatar(image: branche.image),
        title: Text(branche.brancheName),
        subtitle: Text(branche.branchAddressEn),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
