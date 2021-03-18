import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/models/client/company.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';
import 'package:techtime/widgets/client/footer_card.dart';

class CompaniesListView extends StatelessWidget {
  final List<Company> companies;

  const CompaniesListView({Key key, this.companies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0.0, KDefaultPadding, 0.0, KDefaultPadding),
      child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FooterCard(
                width: size.width * 0.95,
                height: 300,
                bgImage: KAPIURL + companies[i].coverImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(KdefaultPadding / 2),
                      child: CustomCircleAvatar(
                        width: 80,
                        height: 80,
                        image: KAPIURL + companies[i]?.logo ?? KPlaceHolder,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            companies[i].companyName,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.subtitle2
                                .copyWith(color: Colors.black),
                          ),
                          RichText(
                              overflow: TextOverflow.clip,
                              textScaleFactor: 0.9,
                              text: TextSpan(
                                text: '${companies[i].categoryRegionEn}   ',
                                style: _theme.textTheme.subtitle2
                                    .copyWith(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${companies[i].categoryCityEn} ',
                                      style: _theme.textTheme.subtitle2
                                          .copyWith(color: Colors.black)),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
