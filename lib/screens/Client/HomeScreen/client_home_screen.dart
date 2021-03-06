import 'package:badges/badges.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/BLoCs/client/offersBlocs/companyOffersBloc/companyoffers_bloc.dart';
import 'package:techtime/Controllers/BLoCs/core/notificationsBloc/notifications_bloc.dart';
import 'package:techtime/Controllers/blocs/client/categorisBloc/categories_bloc.dart';
import 'package:techtime/Controllers/blocs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/blocs/client/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';
import 'package:techtime/Models/client/offers/company_offer.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Screens/Client/Offres/all_companies_offers_screen.dart';
import 'package:techtime/Screens/Client/favorites/favorites_screen.dart';
import 'package:techtime/Widgets/client/company_offer_card.dart';
import 'package:techtime/Widgets/client/offer_card_body.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/screens/Client/Categories/client_categories_screen.dart';
import 'package:techtime/screens/shared/notifications/notifications.dart';
import 'package:techtime/screens/shared/search_screen.dart';
import 'package:techtime/widgets/client/carousel.dart';
import 'package:techtime/widgets/client/category_card.dart';
import 'package:techtime/widgets/client/company_card.dart';
import 'package:techtime/widgets/client/least_company_card.dart';

import 'components/section_header.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  double _sectionHeight = 0.0;
  @override
  void initState() {
    // ignore: close_sinks
    final categoriesBloc = context.read<CategoriesBloc>();
    // ignore: close_sinks
    final recommenddedCompniesBloc = context.read<RecommendedcompaniesBloc>();
    recommenddedCompniesBloc.add(const GetRecommendedCompnies());
    // ignore: close_sinks
    final leastCompniesBloc = context.read<LeastcompaniesBloc>();
    leastCompniesBloc.add(const GetLeastCompanies());
    categoriesBloc.add(GetCatgories());
    final notificationsBloc = context.read<NotificationsBloc>();
    notificationsBloc.add(const GetAllUserNotifications());
    final offersBloc = context.read<CompanyoffersBloc>();
    offersBloc.add(GetCompanyOffers());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CurrentUserProvider>(context, listen: false)
          .loadCurrentUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sectionHeight = MediaQuery.of(context).size.height * 0.16;
    final _currentUser = Provider.of<CurrentUserProvider>(context).currentUser;
    final appTheme = Provider.of<ThemeModel>(context);
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final Snackbar _snackBar = Snackbar();

    return Scaffold(
      appBar: buildAppBar(context, appTheme, _translator, _currentUser),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              buildAdsCarouselContainer(size),
              buildCategoriesSection(context, size, _snackBar),
              if (_currentUser != null) const OffersSection() else Container(),
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
          if (state is LeastCompaniesLoaded) {
            if (state.leastCompanies.isNotEmpty) {
              return SizedBox(
                  height: size.height * .23,
                  child: buildLeastCompaniesData(state));
            }
            if (state.leastCompanies.isEmpty) {
              return Container();
            }
          }
          return SizedBox(
              height: _sectionHeight, child: buildLeastCompaniesLoading(size));
        })
      ],
    );
  }

  ListView buildLeastCompaniesLoading(Size size) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: defaultPadding / 2,
          );
        },
        scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const ShimmerEffect(
            child: LeastCompanyCard(),
          );
        });
  }

  SectionHeader buildLeastCompaniesHeader(BuildContext context) {
    return SectionHeader(
      title: Row(
        children: [
          const Icon(
            Icons.new_releases_sharp,
            color: AppColors.primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            AppLocalizations.of(context)!.translate('newStores')!,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }

  ListView buildLeastCompaniesData(LeastCompaniesLoaded state) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: state.leastCompanies.length,
        itemBuilder: (context, index) {
          return LeastCompanyCard(company: state.leastCompanies[index]);
        });
  }

  Widget buildRecommendedCompanesSection(BuildContext context, Size size) {
    return Column(
      children: [
        SectionHeader(
          title: Row(
            children: [
              const Icon(
                Icons.star_border,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                AppLocalizations.of(context)!.translate('topRated')!,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
        SizedBox(
            height: size.height * .18,
            child: BlocConsumer<RecommendedcompaniesBloc,
                RecommendedcompaniesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is RecommendedcompaniesLoaded) {
                  return buildRecommendedCompaniesData(state);
                }
                return buildRecommendedCoLoading(size);
              },
            )),
      ],
    );
  }

  Column buildCategoriesSection(
      BuildContext context, Size size, Snackbar _snackBar) {
    return Column(
      children: [
        SectionHeader(
          title: Text(
            AppLocalizations.of(context)!.translate('categories')!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          pressed: () => Navigator.pushNamed(
              context, ClientCategoriesScreen.routeName,
              arguments: true),
        ),
        SizedBox(
            height: _sectionHeight,
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
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ShimmerEffect(
            child: CompanyCard(),
          ),
        );
      },
    );
  }

  ListView buildRecommendedCompaniesData(RecommendedcompaniesLoaded state) {
    return ListView.builder(
      // padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
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

  AppBar buildAppBar(BuildContext context, ThemeModel appTheme,
      AppLocalizations _translator, UserProfile? _currentUser) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
          "${_translator.translate('hello')}${_currentUser?.firstName ?? ""} ",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: AppColors.primaryColor)),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // ignore: avoid_redundant_argument_values
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                ),
                                Text(_translator.translate('Alex')!,
                                    style:
                                        Theme.of(context).textTheme.subtitle2)
                              ])
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ))),
      actions: [
        if (_currentUser != null)
          BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsSuccess) {
                return IconButton(
                    icon: Badge(
                        badgeContent: Text(state
                            .notifications.notReadNotification!.length
                            .toString()),
                        // ignore: avoid_redundant_argument_values
                        animationType: BadgeAnimationType.slide,
                        // ignore: avoid_redundant_argument_values
                        toAnimate: true,
                        child: Icon(
                          Icons.notifications_none_outlined,
                          // size: 26,
                          color: Theme.of(context).iconTheme.color,
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, Notifications.routeName,
                          arguments: state.notifications);
                    });
              } else {
                return Icon(
                  Icons.notifications_none_outlined,
                  size: 24,
                  color: Theme.of(context).iconTheme.color,
                );
              }
            },
          )
        else
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              // size: 26,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Fluttertoast.showToast(
                  msg: _translator.translate("please_login_first")!);
            },
          ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
            // height: 16,
          ),
          onPressed: () => Navigator.pushNamed(context, SearchScreen.routeName),
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/svg/favorites.svg",
            color: Theme.of(context).iconTheme.color,
            height: 15,
          ),
          onPressed: () {
            if (_currentUser != null) {
              Navigator.pushNamed(
                context,
                FavoritesScreen.routeName,
              );
            } else {
              Fluttertoast.showToast(
                  msg: _translator.translate("please_login_first")!);
            }
          },
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
          width: size.width * 0.45,
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
      physics: const BouncingScrollPhysics(),
      itemCount: state.categories.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryCard(
          width: size.width * 0.45,
          category: state.categories[index],
        );
      },
    );
  }
}

class OffersSection extends StatefulWidget {
  const OffersSection({
    Key? key,
  }) : super(key: key);

  @override
  _OffersSectionState createState() => _OffersSectionState();
}

class _OffersSectionState extends State<OffersSection> {
  @override
  void initState() {
    BlocProvider.of<CompanyoffersBloc>(context).add(GetCompanyOffers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? _translator = AppLocalizations.of(context);
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<CompanyoffersBloc, CompanyoffersState>(
      builder: (context, state) {
        Widget widget;
        if (state is CompanyoffersSuccess) {
          widget = OffersWithData(
            companiesOffers: state.companyOffers,
          );
        } else {
          widget = ShimmerEffect(
              child: Column(
            children: [
              SectionHeader(
                title: Text(
                  _translator!.translate("offers")!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                pressed: () {},
              ),
              SizedBox(
                height: size.height * 0.16,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (_, i) => const HorizontalGap(
                          width: defaultPadding / 2,
                        ),
                    itemBuilder: (ctx, i) {
                      return CompanyOfferCard(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 120,
                        child: const OfferCardBody(
                          title: "",
                          subtitle: "",
                        ),
                      );
                    }),
              ),
            ],
          ));
        }
        return widget;
      },
    );
  }
}

class OffersWithData extends StatelessWidget {
  const OffersWithData({
    Key? key,
    required this.companiesOffers,
  }) : super(key: key);

  final List<CompanyDataOffer> companiesOffers;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SectionHeader(
          title: Row(children: [
            const Icon(
              Icons.star,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              _translator.translate("offers")!,
              style: Theme.of(context).textTheme.subtitle1,
            )
          ]),
          pressed: () => Navigator.pushNamed(context, OffersScreen.routeName),
        ),
        SizedBox(
          height: size.height * 0.16,
          child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, i) => const HorizontalGap(
                    width: defaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) {
                final offer = companiesOffers[i];
                return CompanyOfferCard(
                  onClick: () =>
                      Navigator.pushNamed(context, OffersScreen.routeName),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 120,
                  child: OfferCardBody(
                    image: offer.companyImage,
                    title: offer.companyName,
                    hint: offer.categoryEn,
                    subtitle:
                        "${offer.companyOffers.toString()}   ${" ${_translator.translate("offers")}"}",
                  ),
                );
              }),
        ),
      ],
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
//             borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
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
//                     width: defaultPadding / 4,
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
