import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/branchEmployeesBloc/brancheemployees_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheOffersBloc/brancheoffers_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheReviewsBloc/branchereviews_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheServicesBloc/brancheservices_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheProfileBloc/branche_profile_bloc.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheOffers/branche_offers.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheProfile/branche_images.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheReviews/branche_reviews.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';
import 'package:techtime/Widgets/client/favorite_button.dart';
import 'package:techtime/Widgets/client/specialist_card.dart';
import 'package:techtime/Widgets/core/gallery_view.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/widgets/client/gradient_card.dart';
import 'package:techtime/widgets/client/offer_card_body.dart';
import 'package:techtime/widgets/client/review_card.dart';
import 'package:techtime/widgets/core/circle_icon.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class BranchProfile extends StatelessWidget {
  static const String routeName = '/Branch_profile';
  final CompanyBranche branche;

  const BranchProfile({Key key, @required this.branche}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Stack(children: [
            const BranchCoverImage(),
            BranchProfileBody(
              branche: branche,
            )
          ])),
    );
  }
}

//Branch Cover Image in the background
class BranchCoverImage extends StatelessWidget {
  const BranchCoverImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Positioned(
      top: -_size.height * .25,
      child: Container(
        width: _size.width,
        height: _size.height * 0.9,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/background.png"))),
      ),
    );
  }
}

//Branch Profile Body White Section Below
class BranchProfileBody extends StatefulWidget {
  const BranchProfileBody({
    Key key,
    @required this.branche,
  }) : super(key: key);
  final CompanyBranche branche;

  @override
  _BranchProfileBodyState createState() => _BranchProfileBodyState();
}

class _BranchProfileBodyState extends State<BranchProfileBody> {
  @override
  void initState() {
    BlocProvider.of<BrancheProfileBloc>(context)
        .add(GetBrancheProfile(widget.branche.brancheID));
    BlocProvider.of<BrancheservicesBloc>(context)
        .add(GetBrancheservices(widget.branche.brancheID));
    BlocProvider.of<BrancheemployeesBloc>(context)
        .add(GetBrancheEmployees(widget.branche.brancheID));
    BlocProvider.of<BranchereviewsBloc>(context)
        .add(GetBrancheReviews(widget.branche.brancheID));
    BlocProvider.of<BrancheOffersBloc>(context)
        .add(GetBrancheOffers(widget.branche.brancheID));

    super.initState();
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BlocConsumer<BrancheProfileBloc, BrancheProfileState>(
              listener: (context, state) {
            if (state is BrancheProfileSuccess) {
              setState(() {
                isFavorite = state.brancheProfile.brancheData.favorite;
              });
            }
          }, builder: (context, state) {
            return Container(
              height: _size.height * 0.65,
              width: _size.width,
              decoration: BoxDecoration(
                  color: _theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Column(
                          children: [
                            //Row of Branch Name and Rating
                            Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      widget.branche.brancheName,
                                      style: _theme.textTheme.headline6,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(defaultPadding),
                                    )),
                                    child: Row(children: [
                                      if (state is BrancheProfileSuccess)
                                        Text(
                                          state.brancheProfile.brancheData.raty
                                              .round()
                                              .toStringAsFixed(1)
                                              .toString(),
                                          style: _theme.textTheme.subtitle2,
                                          overflow: TextOverflow.clip,
                                        )
                                      else
                                        ShimmerEffect(
                                          child: Container(
                                            height: 10,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      const HorizontalGap(
                                        width: 5.0,
                                      ),
                                      const Icon(Icons.star_purple500_sharp,
                                          color: AppColors.primaryColor),
                                    ]),
                                  )
                                ])),
                            const VerticalGap(
                              height: defaultPadding / 2,
                            ),
                            Column(
                              children: [
                                InfoTile(
                                  icon: "assets/svg/home.svg",
                                  description: widget.branche.branchAddressEN,
                                ),
                              ],
                            ),
                            const VerticalGap(
                              height: defaultPadding / 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // color: AppColors.darkGreyColor,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (state is BrancheProfileSuccess)
                              FavoriteButton(
                                buttonSize: 30,
                                isFavorite: isFavorite ?? false,
                                onTap: onLikeButtonTapped,
                              )
                            else
                              const ShimmerEffect(
                                child: FavoriteButton(
                                  buttonSize: 30,
                                ),
                              ),
                            IconButton(
                                icon: const Icon(Icons.sms), onPressed: () {}),
                          ],
                        ),
                      ),
                      //build Branch Previous work data
                      Builder(builder: (context) {
                        if (state is BrancheProfileSuccess) {
                          if (state.brancheProfile.brancheImages.isNotEmpty) {
                            return buildPreviousWorkData(_size, _theme,
                                state.brancheProfile.brancheImages);
                          } else {
                            return Container();
                          }
                        } else {
                          return buildPreviousWorkLoading();
                        }
                      }),

                      //build Branch Previous work data
                      BlocBuilder<BrancheservicesBloc, BrancheservicesState>(
                        builder: (context, state) {
                          if (state is BrancheservicesSuccess) {
                            if (state.services.isNotEmpty) {
                              return buildServicesData(
                                  _translator, _theme, state.services);
                            } else {
                              return Container();
                            }
                          }
                          return buildServicesLoading(_translator, _theme);
                        },
                      ),

                      //build Branch specialists
                      BlocBuilder<BrancheemployeesBloc, BrancheemployeesState>(
                        builder: (context, state) {
                          if (state is BrancheemployeesSuccess) {
                            if (state.employees.isNotEmpty) {
                              return buildEmployeesData(
                                  _translator, _size, _theme, state.employees);
                            } else {
                              return Container();
                            }
                          }
                          return buildEmployeesLoading(
                              _translator, _size, _theme);
                        },
                      ),
                      //build our Offers section
                      BlocBuilder<BrancheOffersBloc, BrancheOffersState>(
                        builder: (context, state) {
                          if (state is BrancheOffersSuccess) {
                            if (state.offers.isNotEmpty) {
                              return buildOffersData(
                                  _translator, _size, _theme, state.offers);
                            } else {
                              return Container();
                            }
                          }
                          return buildOffersLoading(_translator, _size, _theme);
                        },
                      ),

                      BlocBuilder<BranchereviewsBloc, BranchereviewsState>(
                        builder: (context, state) {
                          if (state is BrancheReviewsSuccess) {
                            if (state.reviews.reviews.isNotEmpty) {
                              return buildReviewsData(
                                  _translator, _size, _theme, state.reviews);
                            } else {
                              return Container();
                            }
                          }
                          return buildReviewsLoading(
                              _translator, _size, _theme);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          BranchProfilePicture(
            branche: widget.branche,
          ),
        ],
      ),
    );
  }

  Column buildOffersData(AppLocalizations _translator, Size _size,
      ThemeData _theme, List<BrancheOffer> offers) {
    return Column(
      children: [
        SubTitle(text: _translator.translate("offers")),
        SizedBox(
          height: 150,
          child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              itemCount: offers.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, i) => const HorizontalGap(
                    width: defaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) {
                final BrancheOffer offer = offers[i];
                return GradientCard(
                  width: _size.width * 0.9,
                  height: 120,
                  child: OfferCardBody(
                    image: offer.offerImage,
                    title: offer.offerName,
                    subtitle:
                        "${offer.price}${" ${_translator.translate("EGP")}"}",
                  ),
                );
              }),
        ),
      ],
    );
  }

  ShimmerEffect buildOffersLoading(
      AppLocalizations _translator, Size _size, ThemeData _theme) {
    return ShimmerEffect(
      child: Column(
        children: [
          SubTitle(text: _translator.translate("offers")),
          SizedBox(
            height: 150,
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, i) => const HorizontalGap(
                      width: defaultPadding / 2,
                    ),
                itemBuilder: (ctx, i) => GradientCard(
                      width: _size.width * 0.9,
                      height: 120,
                      child: const OfferCardBody(
                        image: placeHolderImage,
                        title: '',
                        subtitle: '',
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  Widget buildReviewsLoading(
      AppLocalizations _translator, Size _size, ThemeData _theme) {
    return ShimmerEffect(
      child: Column(
        children: [
          SubTitle(
            text: _translator.translate("reviews"),
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, i) => const HorizontalGap(
                width: defaultPadding / 2,
              ),
              itemBuilder: (ctx, i) => const ReviewCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviewsData(AppLocalizations _translator, Size _size,
      ThemeData _theme, BrancheReviews reviews) {
    return Column(
      children: [
        SubTitle(
          text: _translator.translate("reviews"),
        ),
        SizedBox(
          height: 150,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            itemCount: reviews.reviews.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, i) => const HorizontalGap(
              width: defaultPadding / 2,
            ),
            itemBuilder: (ctx, i) => ReviewCard(
              review: reviews.reviews[i],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmployeesLoading(
      AppLocalizations _translator, Size _size, ThemeData _theme) {
    return ShimmerEffect(
        child: Column(
      children: [
        SubTitle(text: _translator.translate("staff")),
        SizedBox(
          height: 100,
          child: ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              separatorBuilder: (_, i) => const HorizontalGap(
                    width: defaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) => const SpecialistCard()),
        ),
      ],
    ));
  }

  Column buildEmployeesData(AppLocalizations _translator, Size _size,
      ThemeData _theme, List<CompanyEmployee> employees) {
    return Column(
      children: [
        SubTitle(text: _translator.translate("staff")),
        SizedBox(
          height: 100,
          child: ListView.separated(
              itemCount: employees.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              separatorBuilder: (_, i) => const HorizontalGap(
                    width: defaultPadding / 2,
                  ),
              itemBuilder: (ctx, i) => SpecialistCard(
                    companyEmployee: employees[i],
                  )),
        ),
      ],
    );
  }

  Widget buildServicesLoading(AppLocalizations _translator, ThemeData _theme) {
    return ShimmerEffect(
      child: Column(
        children: [
          SubTitle(text: _translator.translate("services")),
          SizedBox(
            height: 100,
            child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                separatorBuilder: (_, i) => const HorizontalGap(),
                itemBuilder: (ctx, i) => const ServiceRRect()),
          ),
        ],
      ),
    );
  }

  Column buildServicesData(AppLocalizations _translator, ThemeData _theme,
      List<CompanyService> services) {
    return Column(
      children: [
        SubTitle(text: _translator.translate("services")),
        SizedBox(
          height: 120,
          child: ListView.separated(
              itemCount: services.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              separatorBuilder: (_, i) => const HorizontalGap(),
              itemBuilder: (ctx, i) => ServiceRRect(
                    companyService: services[i],
                  )),
        ),
      ],
    );
  }

  Widget buildPreviousWorkLoading() {
    return ShimmerEffect(
      child: Column(
        children: [
          SubTitle(text: AppLocalizations.of(context).translate("our_gallery")),
          SizedBox(
            height: 150,
            child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, i) => const HorizontalGap(),
                itemBuilder: (ctx, i) => const PreviousWorkCard()),
          ),
        ],
      ),
    );
  }

  Column buildPreviousWorkData(
      Size _size, ThemeData _theme, List<BrancheImage> images) {
    return Column(
      children: [
        SubTitle(text: AppLocalizations.of(context).translate("our_gallery")),
        SizedBox(
          height: 150,
          child: ListView.separated(
              itemCount: images.length,
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, i) => const HorizontalGap(),
              itemBuilder: (ctx, i) => PreviousWorkCard(
                    image: images[i],
                    onTap: () => Navigator.pushNamed(
                        context, GalleryView.routeName,
                        arguments: {
                          'imgList': images.map((e) => e.image).toList(),
                          'companyName': widget.branche.brancheName
                        }),
                  )),
        ),
      ],
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Future<bool> onLikeButtonTapped(bool isFav) async {
    assert(isFav != null);
    // / send your request here
    final bool isFavorite = await BranchesRepository()
        .brancheAddRemoveFavorite(widget.branche.brancheID);

    // / if failed, you can do nothing
    return isFavorite;
  }
}

class ServiceRRect extends StatelessWidget {
  const ServiceRRect({
    Key key,
    this.companyService,
  }) : super(key: key);
  final CompanyService companyService;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: companyService?.image != null
                      ? NetworkImage(
                          NetworkConstants.baseUrl + companyService.image,
                        ) as ImageProvider
                      : const AssetImage(placeHolderImage),
                ))),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: (companyService != null)
                  ? SizedBox(
                      width: _size.width * 0.3,
                      child: Text(
                        companyService.nameServicesAr,
                        style: _theme.textTheme.subtitle2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Container(
                      width: defaultPadding * 2,
                      height: defaultPadding / 2,
                      color: Colors.white,
                    ))
        ],
      ),
    );
  }
}

// a Column for Previous Work.
class PreviousWorkCard extends StatelessWidget {
  const PreviousWorkCard({
    Key key,
    this.image,
    this.onTap,
  }) : super(key: key);
  final BrancheImage image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Material(
        child: Container(
          width: _size.width * 0.45,
          height: 130,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (image != null)
                      ? NetworkImage(NetworkConstants.baseUrl + image.image)
                          as ImageProvider
                      : const AssetImage(placeHolderImage)),
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultPadding / 4))),
        ),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          const VerticalGap(),
          Row(
            children: [
              Text(
                text,
                style: _theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const VerticalGap(),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({
    Key key,
    @required this.icon,
    @required this.description,
  }) : super(key: key);
  final String icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIcon(
          icon: icon,
        ),
        const SizedBox(width: 5),
        Text(
          description,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}

// Branch Profile Picture at the top of the white slider
class BranchProfilePicture extends StatelessWidget {
  const BranchProfilePicture({
    Key key,
    this.branche,
  }) : super(key: key);
  final CompanyBranche branche;
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Positioned(
      top: -70,
      right: 10,
      child: Container(
        width: 100.0,
        height: 100.0,
        margin: const EdgeInsets.all(defaultPadding / 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(width: 2, color: AppColors.primaryColor),
          image: DecorationImage(
              image: (branche.image != null)
                  ? NetworkImage(NetworkConstants.baseUrl + branche.image)
                      as ImageProvider
                  : const AssetImage(placeHolderImage),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
              color: _theme.shadowColor.withOpacity(0.3),
            ),
            BoxShadow(
              color: _theme.scaffoldBackgroundColor,
              spreadRadius: -12.0,
              blurRadius: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
