import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Controllers/blocs/client/companyProfileBloc/company_profile_bloc.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/models/client/company.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

import 'components/branch_list_tile.dart';

class CompanyProfile extends StatefulWidget {
  final Company company;
  static const String routeName = "/company_profile";

  const CompanyProfile({Key key, this.company}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  void initState() {
    BlocProvider.of<CompanyProfileBloc>(context)
        .add(GetCompanyProfile(widget.company.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildCompanyCover(context),
                    buildRatingShareBar(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: KDefaultPadding / 2),
                  child: BlocConsumer<CompanyProfileBloc, CompanyProfileState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is CompanyProfileLoading ||
                          state is CompanyProfileInitial) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CompanyProfileFinished) {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.companyBranches.length,
                            itemBuilder: (context, i) => BranchListTile(
                              branche: state.companyBranches[i],
                              onTap: () {},
                            ),
                          ),
                        );
                      } else if (state is CompanyProfileError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCompanyLogo(context),
              VerticalGap(),
              buildCompanyName(context),
              buildCompanyCategory(context),
            ],
          ))
        ],
      ),
    );
  }

  Text buildCompanyCategory(BuildContext context) {
    return Text(
      widget.company.categoryEn,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  Text buildCompanyName(BuildContext context) {
    return Text(
      widget.company.companyName,
      style: Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 20, fontWeight: FontWeight.bold, wordSpacing: 3.5),
    );
  }

  Hero buildCompanyLogo(BuildContext context) {
    return Hero(
        tag: widget.company.companyName,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: KdefaultPadding / 4),
          padding: EdgeInsets.all(2),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: KPrimaryColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(KdefaultRadius)),
              image: DecorationImage(
                  image: widget.company.logo != null
                      ? NetworkImage(KAPIURL + widget.company.logo)
                      : AssetImage(KPlaceHolderImage),
                  repeat: ImageRepeat.noRepeat,
                  // alignment: Alignment.center,
                  fit: BoxFit.fill)),
        ));
  }

  Padding buildRatingShareBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KdefaultPadding, vertical: KdefaultPadding / 2),
      child: Row(
        children: [
          SmoothStarRating(
            size: 18,
            rating: widget.company.raty,
            allowHalfRating: true,
            isReadOnly: true,
          ),
          Spacer(),
          Icon(
            Icons.share_outlined,
            size: 35,
            color: KPrimaryColor,
          )
        ],
      ),
    );
  }

  Container buildCompanyCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: widget.company.coverImage != null
            ? NetworkImage(
                KAPIURL + widget.company.coverImage,
              )
            : AssetImage(KPlaceHolderCover),
        fit: BoxFit.fill,
      )),
    );
  }
}
