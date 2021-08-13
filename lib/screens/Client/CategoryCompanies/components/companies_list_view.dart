import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/screens/Client/companyProfile/company_profile.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';
import 'package:techtime/widgets/client/footer_card.dart';

class CompaniesListView extends StatelessWidget {
  final List<Company>? companies;

  const CompaniesListView({Key? key, this.companies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.fromLTRB(0.0, defaultPadding, 0.0, defaultPadding),
      child: ListView.builder(
          itemCount: companies!.length,
          itemBuilder: (_, i) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, CompanyProfile.routeName,
                      arguments: companies![i]),
                  child: FooterCard(
                    width: size.width * 0.95,
                    height: size.height * .25,
                    bgImage: companies![i].coverImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding / 2),
                          child: Hero(
                              tag: companies![i].companyName!,
                              child: CustomCircleAvatar(
                                width: 70,
                                height: 70,
                                image: companies![i].logo,
                              )),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                companies![i].companyName!,
                                overflow: TextOverflow.ellipsis,
                                style: _theme.textTheme.subtitle2!
                                    .copyWith(color: Colors.black),
                              ),
                              RichText(
                                  textScaleFactor: 0.9,
                                  text: TextSpan(
                                    text:
                                        '${companies![i].categoryRegionEn}   ',
                                    style: _theme.textTheme.subtitle2!
                                        .copyWith(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '${companies![i].categoryCityEn} ',
                                          style: _theme.textTheme.subtitle2!
                                              .copyWith(color: Colors.black)),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
