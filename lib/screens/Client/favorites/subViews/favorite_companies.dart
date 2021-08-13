import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/favoritesBloc/favorites_bloc.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/Screens/Client/companyProfile/company_profile.dart';
import 'package:techtime/Widgets/client/custom_circle_avatar.dart';
import 'package:techtime/Widgets/client/footer_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';

class FavoriteCompanies extends StatefulWidget {
  const FavoriteCompanies({
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteCompaniesState createState() => _FavoriteCompaniesState();
}

class _FavoriteCompaniesState extends State<FavoriteCompanies> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(GetFavoriteCompanies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) {
        return current is FavoritesCompaniessuccess;
      },
      builder: (context, state) {
        Widget widget;
        if (state is FavoritesCompaniessuccess) {
          if (state.companies.isNotEmpty) {
            widget = FavoriteCompaniesWithData(
              companies: state.companies,
            );
          } else {
            widget = const Center(
              child: Text("Empty State"),
            );
          }
        } else {
          widget = const FavoriteCompaniesShimmer();
        }
        return widget;
      },
    );
  }
}

class FavoriteCompaniesWithData extends StatelessWidget {
  const FavoriteCompaniesWithData({
    Key? key,
    required this.companies,
  }) : super(key: key);

  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.fromLTRB(0.0, defaultPadding, 0.0, defaultPadding),
      child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (_, i) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, CompanyProfile.routeName,
                      arguments: companies[i]),
                  child: FooterCard(
                    width: size.width * 0.95,
                    height: size.height * .25,
                    bgImage: companies[i].coverImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding / 2),
                          child: Hero(
                              tag: companies[i].companyName!,
                              child: CustomCircleAvatar(
                                width: 80,
                                height: 80,
                                image: companies[i].logo,
                              )),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                companies[i].companyName!,
                                overflow: TextOverflow.ellipsis,
                                style: _theme.textTheme.subtitle2!
                                    .copyWith(color: Colors.black),
                              ),
                              RichText(
                                  textScaleFactor: 0.9,
                                  text: TextSpan(
                                    text: '${companies[i].categoryRegionEn}   ',
                                    style: _theme.textTheme.subtitle2!
                                        .copyWith(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '${companies[i].categoryCityEn} ',
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

class FavoriteCompaniesShimmer extends StatelessWidget {
  const FavoriteCompaniesShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.fromLTRB(0.0, defaultPadding, 0.0, defaultPadding),
      child: ShimmerEffect(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, i) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () => {},
                    child: FooterCard(
                      width: size.width * 0.95,
                      height: size.height * .25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(defaultPadding / 2),
                            child: CustomCircleAvatar(
                              width: 80,
                              height: 80,
                              image: null,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "",
                                  overflow: TextOverflow.ellipsis,
                                  style: _theme.textTheme.subtitle2!
                                      .copyWith(color: Colors.black),
                                ),
                                RichText(
                                    textScaleFactor: 0.9,
                                    text: TextSpan(
                                      text: '',
                                      style: _theme.textTheme.subtitle2!
                                          .copyWith(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '',
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
      ),
    );
  }
}
