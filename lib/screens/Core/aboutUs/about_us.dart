import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:techtime/Helpers/app_data.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/oval_bottom_clipper.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = "/about_us";
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // ThemeData _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          height: _size.height * 0.2,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/background.png",
                ),
                fit: BoxFit.cover),
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: const AboutUsBody(),
    );
  }
}

class AboutUsBody extends StatelessWidget {
  const AboutUsBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
            child: ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: _size.height * 0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/background.png",
                  ),
                  fit: BoxFit.cover),
              color: AppColors.primaryColor,
            ),
            child: Center(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/logo.svg",
                    height: 50,
                  ),
                  const Text(NetworkConstants.appName,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Text("V ${AppInfo.version}",
                      style: _theme.textTheme.caption.copyWith(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )),
          ),
        )),
        Expanded(
            flex: 3,
            child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      const AboustSection(
                        header: "About Tech Time",
                        paragraph:
                            "Tech Time is a single booking application for everyday needs. The easiest platform to book your services from multiple places in different businesses. Book your services and save your time using technology",
                      ),
                      const AboustSection(
                        header: "Our Mission To Fight The Corona Virus !",
                        paragraph:
                            "Get safe from one-click virus infection with our booking Application, We will help you to avoid crowding indoors and maintain your health. #Stay_Safe_Use_Tech Time.",
                      ),
                      const AboustSection(
                        header: "For Businesses",
                        paragraph:
                            "List your business on Tech Time and attract more customers online.",
                      ),
                      Column(
                        children: const <Widget>[
                          BusinessOptionTile(
                              icon: Icons.calendar_today_outlined,
                              header: "Online Booking",
                              body:
                                  "With your own booking page on Tech Time you make it easy for your customers to make appointments."),
                          BusinessOptionTile(
                              icon: Icons.star_border_outlined,
                              header: "Reviews",
                              body:
                                  "Tech time make it easy for customers to write a review that allows you to create a better customer experience"),
                          BusinessOptionTile(
                              icon: Icons.person_add,
                              header: "Get More Customer",
                              body:
                                  "Increased online visibility gives you more customers."),
                          BusinessOptionTile(
                              icon: Icons.app_settings_alt,
                              header: "Admin App",
                              body:
                                  "With admin App you can manage your bookings , Add your services and your Staff."),
                          BusinessOptionTile(
                              icon: Icons.notifications_active_sharp,
                              header: "Notification System",
                              body:
                                  "Notifications ensures your customers do not forget bookings."),
                          BusinessOptionTile(
                              icon: Icons.headset_mic_rounded,
                              header: "Technical Support",
                              body:
                                  "Having a trouble using Tech Time? We are here to help you."),
                        ],
                      ),
                      const AboustSection(
                        header: "For Customers",
                        paragraph: '''
                            • Tech Time covers a wide range of businesses.
• Book an appointment nearby.
• Explore all the year offers nearby.
• Get reminded of your upcoming bookings.
• Manage your invoices.
• Easily communicate with businesses via the built-in chat.
• Enjoy the booking journey through our delightful UI/UX.''',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "© 2021 Tech Time All rights reserved. \n Powered by TechTime",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: _theme.textTheme.caption
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ))),
      ],
    );
  }
}

class BusinessOptionTile extends StatelessWidget {
  const BusinessOptionTile({
    Key key,
    @required this.icon,
    @required this.header,
    @required this.body,
  }) : super(key: key);
  final IconData icon;
  final String header;
  final String body;
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.15, vertical: 15),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          horizontalTitleGap: 0,
          leading: Icon(
            icon,
            size: 25.0,
            color: AppColors.primaryColor,
          ),
          title: Text(header,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: _theme.textTheme.caption.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text(
            '''
            $body''',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
          ),
          dense: true,
        ),
      ),
    );
  }
}

class AboustSection extends StatelessWidget {
  const AboustSection({
    Key key,
    this.header,
    this.paragraph,
  }) : super(key: key);
  final String header;
  final String paragraph;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            header,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: _theme.textTheme.subtitle2.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: _size.width * 0.8,
            child: Text(
              '''
              $paragraph''',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.justify,
              style: _theme.textTheme.caption.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
