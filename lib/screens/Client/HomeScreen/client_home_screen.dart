import 'package:badges/badges.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/blocs/client/categorisBloc/categories_bloc.dart';
import 'package:techtime/Controllers/blocs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/blocs/client/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/Controllers/Providers/current_user_provider.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/themes/dark_theme.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/screens/Client/Categories/client_categories_screen.dart';
import 'package:techtime/screens/Core/notifications/notifications.dart';
import 'package:techtime/screens/Core/search_screen.dart';
import 'package:techtime/widgets/client/carousel.dart';
import 'package:techtime/widgets/client/category_card.dart';
import 'package:techtime/widgets/client/company_card.dart';
import 'package:techtime/widgets/client/least_company_card.dart';
import 'package:techtime/widgets/core/skeleton.dart';

import 'components/section_header.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  void initState() {
    // ignore: close_sinks
    final categoriesBloc = context.read<CategoriesBloc>();
    // ignore: close_sinks
    final recommenddedCompniesBloc = context.read<RecommendedcompaniesBloc>();
    recommenddedCompniesBloc.add(GetRecommendedCompnies());
    // ignore: close_sinks
    final leastCompniesBloc = context.read<LeastcompaniesBloc>();
    leastCompniesBloc.add(GetLeastCompanies());
    categoriesBloc.add(GetCatgories());
    CurrentUserProvider().loadCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProfile _currentUser = context.watch<CurrentUserProvider>().currentUser;
    var appTheme = Provider.of<ThemeModel>(context);
    AppLocalizations _translator = AppLocalizations.of(context);
    Snackbar _snackBar = Snackbar();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context, appTheme, _translator, _currentUser),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              buildAdsCarouselContainer(size),
              buildCategoriesSection(context, size, _snackBar),
              buildRecommendedCompanesSection(context, size),
              buildLeastCompaniesSection(context, size, _snackBar)
            ],
          ),
        ),
      ),
    );
  }

  Column buildLeastCompaniesSection(
      BuildContext context, Size size, Snackbar _snackbar) {
    return Column(
      children: [
        BlocBuilder<LeastcompaniesBloc, LeastcompaniesState>(
            builder: (context, state) {
          if (state is LeastCompaniesLoaded) {
            if (state.leastCompanies.isNotEmpty) {
              return buildLeastCompaniesHeader(context);
            } else {
              return Container();
            }
          }
          return buildLeastCompaniesHeader(context);
        }),
        BlocConsumer<LeastcompaniesBloc, LeastcompaniesState>(
            listener: (context, state) {
          if (state is LeastCompaniesError) {
            _snackbar.showSnackBar(context, state.message);
          }
        }, builder: (context, state) {
          if (state is LeastCompaniesError) {
            return buildError(state);
          }
          if (state is LeastCompaniesLoaded) {
            if (state.leastCompanies.isNotEmpty) {
              return Container(
                  height: size.height * 0.35,
                  child: buildLeastCompaniesData(state));
            }
            if (state.leastCompanies.isEmpty) {
              return Container();
            }
          }
          return Container(
              height: size.height * 0.35,
              child: buildLeastCompaniesLoading(size));
        })
      ],
    );
  }

  ListView buildLeastCompaniesLoading(Size size) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            width: KDefaultPadding / 2,
          );
        },
        scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShimmerEffect(
            child: LeastCompanyCard(),
          );
        });
  }

  Center buildError(var state) {
    return Center(
      child: Text(state.message),
    );
  }

  SectionHeader buildLeastCompaniesHeader(BuildContext context) {
    return SectionHeader(
      title: Row(
        children: [
          Icon(
            Icons.new_releases_sharp,
            color: KPrimaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            AppLocalizations.of(context).translate('newStores'),
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }

  ListView buildLeastCompaniesData(LeastCompaniesLoaded state) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: state.leastCompanies.length,
        itemBuilder: (context, index) {
          return LeastCompanyCard(company: state.leastCompanies[index]);
        });
  }

  Padding buildRecommendedCompanesSection(BuildContext context, Size size) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            SectionHeader(
              title: Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: KPrimaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('topRated'),
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
            ),
            SizedBox(
                height: size.height * .25,
                child: BlocConsumer<RecommendedcompaniesBloc,
                    RecommendedcompaniesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is RecommendedcompaniesLoaded) {
                      return buildRecommendedCompaniesData(state);
                    } else if (state is RecommendedcompaniesError) {
                      return buildError(state);
                    }
                    return buildRecommendedCoLoading(size);
                  },
                )),
          ],
        ));
  }

  Column buildCategoriesSection(
      BuildContext context, Size size, Snackbar _snackBar) {
    return Column(
      children: [
        SectionHeader(
          title: Text(
            AppLocalizations.of(context).translate('categories'),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          pressed: () => Navigator.pushNamed(
              context, ClientCategoriesScreen.routeName,
              arguments: true),
        ),
        SizedBox(
            height: size.height * 0.15,
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.right,
              color: Colors.transparent,
              child: BlocConsumer<CategoriesBloc, CategoriesState>(
                  listener: (context, state) {
                if (state is CategoriesError) {
                  _snackBar.showSnackBar(
                    context,
                    state.message,
                  );
                }
              }, builder: (context, state) {
                if (state is CategoriesLoading || state is CategoriesInitial) {
                  return buildCategoriesLoading(size);
                } else if (state is CategoriesLoaded) {
                  return buildCategoriessData(state, size);
                } else if (state is CategoriesError) {
                  return buildError(state);
                }
                return Container();
              }),
            )),
      ],
    );
  }

  ListView buildRecommendedCoLoading(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ShimmerEffect(
            child: CompanyCard(),
          ),
        );
      },
    );
  }

  ListView buildRecommendedCompaniesData(RecommendedcompaniesLoaded state) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: state.recommendedCompanies.length,
      itemBuilder: (BuildContext context, int index) {
        return CompanyCard(company: state.recommendedCompanies[index]);
      },
    );
  }

  Widget buildAdsCarouselContainer(Size size) {
    return Wrap(children: [CarouselWithIndicator()]);
  }

  Widget buildAppBar(BuildContext context, ThemeModel appTheme,
      AppLocalizations _translator, UserProfile _currentUser) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
          "${_translator.translate('hello')}${_currentUser?.firstName ?? ""} ",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: KPrimaryColor)),
      bottom: PreferredSize(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text(
                          //   _translator.translate('yourLocation'),
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .subtitle2
                          //       .copyWith(color: KDarkGreyColor),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Row(
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.location_on_outlined,
                                ),
                                Text(_translator.translate('Alex'),
                                    style:
                                        Theme.of(context).textTheme.headline5)
                              ])
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.brightness_5),
                          Switch(
                            activeColor: KPrimaryColor,
                            value: appTheme.currentTheme == darkTheme
                                ? true
                                : false,
                            onChanged: (toggle) =>
                                Provider.of<ThemeModel>(context, listen: false)
                                    .toggleTheme(),
                          ),
                          Icon(Icons.brightness_3_sharp)
                        ],
                      ),
                    ],
                  ),
                  // VerticalGap(),
                  // HomeSearchBox(),
                  // VerticalGap(),
                ],
              )),
          preferredSize: Size.fromHeight(40.0)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(KDefaultPadding / 8),
          child: IconButton(
              icon: _currentUser != null
                  ? Badge(
                      badgeContent: Text('2'),
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      child: Icon(
                        Icons.notifications_none_outlined,
                        // size: 26,
                        color: Theme.of(context).iconTheme.color,
                      ))
                  : Icon(
                      Icons.notifications_none_outlined,
                      // size: 26,
                      color: Theme.of(context).iconTheme.color,
                    ),
              onPressed: () {
                if (_currentUser != null) {
                  Navigator.pushNamed(context, Notifications.routeName);
                } else {
                  Fluttertoast.showToast(
                      msg: _translator.translate("please_login_first"));
                }
              }),
        ),
        Padding(
            padding: const EdgeInsets.all(KDefaultPadding / 8),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
                // height: 16,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, SearchScreen.routeName),
            )),
        Padding(
          padding: const EdgeInsets.all(KDefaultPadding / 8),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/svg/favorites.svg",
              color: Theme.of(context).iconTheme.color,
              // height: 16,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget buildCategoriesLoading(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ShimmerEffect(
            child: CategoryCard(
          width: size.width * 0.40,
        ));
      },
    );
  }

  Center categoriesError(CategoriesError state) {
    return Center(
      child: Text(state.message),
    );
  }

  ListView buildCategoriessData(CategoriesLoaded state, Size size) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: state.categories.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryCard(
          width: size.width * 0.40,
          category: state.categories[index],
        );
      },
    );
  }
}

// class HomeSearchBox extends StatelessWidget {
//   const HomeSearchBox({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations _translator = AppLocalizations.of(context);
//     return InkWell(
//       onTap: () => Navigator.pushNamed(context, SearchScreen.routeName),
//       child: Hero(
//           tag: "SearchBox",
//           child: Material(
//             elevation: 5,
//             borderRadius: BorderRadius.all(Radius.circular(KdefaultRadius)),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Text(_translator.translate("search_place_holder"),
//                         style: Theme.of(context)
//                             .textTheme
//                             .caption
//                             .copyWith(color: Colors.grey[500])),
//                   ),
//                   Spacer(),
//                   Icon(
//                     Icons.filter_alt_outlined,
//                     size: 30,
//                     color: Colors.grey[400],
//                   ),
//                   HorizontalGap(
//                     width: KdefaultPadding / 4,
//                   ),
//                   Icon(
//                     Icons.search,
//                     size: 30,
//                     color: Colors.grey[400],
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
