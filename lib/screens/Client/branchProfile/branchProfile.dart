import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/widgets/client/gradient_card.dart';
import 'package:techtime/widgets/client/offer_card_body.dart';
import 'package:techtime/widgets/client/review_card.dart';
import 'package:techtime/widgets/core/circle_icon.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/section_header_more.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class BranchProfile extends StatelessWidget {
  static const String routeName = '/salon_profile';
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
            width: _size.width,
            height: _size.height,
            child: Stack(children: [SalonCoverImage(), BranchProfileBody()])),
        persistentFooterButtons: [
          BottomBookingButton(
            onPressed: () {
              print("Booking");
            },
          )
        ]);
  }
}

//bottom Booking Fixed Button
class BottomBookingButton extends StatelessWidget {
  const BottomBookingButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              // ignore: deprecated_member_use
              child: RaisedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "book_now",
                  style: Theme.of(context).textTheme.button,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

//Salon Cover Image in the background
class SalonCoverImage extends StatelessWidget {
  const SalonCoverImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Positioned(
      top: -_size.height * .25,
      child: Container(
          width: _size.width,
          height: _size.height * 0.9,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/salon_back_ground.jpg")))),
    );
  }
}

//Salon Profile Body White Section Below
class BranchProfileBody extends StatelessWidget {
  const BranchProfileBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: _size.height * 0.65,
            width: _size.width,
            decoration: BoxDecoration(
                color: _theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: KDefaultPadding),
                      child: Column(
                        children: [
                          SalonNameAndRating(),
                          VerticalGap(
                            height: KDefaultPadding / 2,
                          ),
                          SalonInfo(),
                          VerticalGap(
                            height: KDefaultPadding / 2,
                          ),
                        ],
                      ),
                    ),
                    ShareOptionsBar(),
                    //build Salon Previous work data
                    SubTitle(text: "صور من أعمالنا"),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (_, i) => HorizontalGap(),
                          itemBuilder: (ctx, i) =>
                              PreviousWorkCard(size: _size, theme: _theme)),
                    ),
                    //build Salon Previous work data
                    SubTitle(text: _translator.translate("services")),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (_, i) => HorizontalGap(),
                          itemBuilder: (ctx, i) => ServiceRRect(theme: _theme)),
                    ),

                    //build Salon specialists
                    SubTitle(text: _translator.translate("staff")),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (_, i) => HorizontalGap(
                                width: KDefaultPadding / 2,
                              ),
                          itemBuilder: (ctx, i) =>
                              SpecialistCard(size: _size, theme: _theme)),
                    ),
                    //build our Offers section
                    SubTitle(text: _translator.translate("offers")),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: KDefaultPadding / 2),
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (_, i) => HorizontalGap(
                                width: KDefaultPadding / 2,
                              ),
                          itemBuilder: (ctx, i) => GradientCard(
                                width: _size.width * 0.9,
                                height: 120,
                                child: OfferCardBody(
                                  theme: _theme,
                                  image: KPlaceHolderImage,
                                  title: 'على استعداد \n لتلبية كافة متطلبات\n',
                                  subtitle: 'خصم 25 %',
                                ),
                              )),
                    ),
                    SectionHeaderMore(
                      header: 'reviews',
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: KDefaultPadding / 2),
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (_, i) => HorizontalGap(
                          width: KDefaultPadding / 2,
                        ),
                        itemBuilder: (ctx, i) =>
                            ReviewCard(size: _size, theme: _theme),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BranchProfilePicture(),
        ],
      ),
    );
  }
}

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({
    Key key,
    @required Size size,
    @required ThemeData theme,
  })  : _size = size,
        _theme = theme,
        super(key: key);

  final Size _size;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: _size.width * 0.15,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/profile_photo.png")),
                borderRadius:
                    BorderRadius.all(Radius.circular(KDefaultPadding))),
          ),
          Text("موظفة ",
              style: _theme.textTheme.caption
                  .copyWith(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class ServiceRRect extends StatelessWidget {
  const ServiceRRect({
    Key key,
    @required ThemeData theme,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 70,
              height: 70,
              color: KSecondryColor,
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg/makeup.svg",
                  height: 40,
                ),
              ),
            ),
          ),
          Text("مكياج العروسة", style: _theme.textTheme.subtitle2)
        ],
      ),
    );
  }
}

// a Column for Previous Work.
class PreviousWorkCard extends StatelessWidget {
  const PreviousWorkCard({
    Key key,
    @required Size size,
    @required ThemeData theme,
  })  : _size = size,
        _theme = theme,
        super(key: key);

  final Size _size;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _size.width * 0.3,
          height: 115,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(KPlaceHolderImage)),
              borderRadius: BorderRadius.all(Radius.circular(KDefaultPadding))),
        ),
        Text(
          "مكياج عروسة",
          style: _theme.textTheme.caption,
        )
      ],
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
    ThemeData _theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: KDefaultPadding),
      child: Column(
        children: [
          VerticalGap(),
          Row(
            children: [
              Text(
                text,
                style: _theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          VerticalGap(),
        ],
      ),
    );
  }
}

class ShareOptionsBar extends StatelessWidget {
  const ShareOptionsBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KDarkGreyColor,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
          IconButton(icon: Icon(Icons.sms), onPressed: () {}),
          IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
    );
  }
}

class SalonInfo extends StatelessWidget {
  const SalonInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoTile(
          icon: "assets/svg/account.svg",
          description: "صاحبة الصالون",
        ),
        InfoTile(
          icon: "assets/svg/home.svg",
          description: " شارع 45, الإسكندرية",
        ),
        InfoTile(
          icon: "assets/svg/schedule.svg",
          description: "مواعيد العمل من السبت -الخميس 9 AM-7 PM",
        ),
      ],
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
        SizedBox(width: 5),
        Text(description)
      ],
    );
  }
}

//Row of Salon Name and Rating
class SalonNameAndRating extends StatelessWidget {
  const SalonNameAndRating({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.only(top: 40),
        child: Row(children: [
          Text(
            "بيوتى صالون",
            style: _theme.textTheme.headline6,
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(KDefaultPadding),
            )),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(4.8.toString(), style: _theme.textTheme.subtitle2),
                  HorizontalGap(
                    width: 5.0,
                  ),
                  Icon(Icons.star_purple500_sharp, color: KPrimaryColor),
                ]),
          )
        ]));
  }
}

// Salon Profile Picture at the top of the white slider
class BranchProfilePicture extends StatelessWidget {
  const BranchProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Positioned(
      top: -70,
      right: 10,
      child: Container(
        width: 100.0,
        height: 100.0,
        margin: EdgeInsets.all(KDefaultPadding / 4),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(width: 2, color: KPrimaryColor),
          image: DecorationImage(
              image: AssetImage(KPlaceHolderImage), fit: BoxFit.cover),
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
