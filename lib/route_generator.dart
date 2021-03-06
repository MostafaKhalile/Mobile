import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Models/client/category.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';
import 'package:techtime/Models/client/offers/company_offer.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';
import 'package:techtime/Screens/Client/Offres/all_companies_offers_screen.dart';
import 'package:techtime/Screens/Client/Offres/company_offers_screen.dart';
import 'package:techtime/Screens/Client/favorites/favorites_screen.dart';
import 'package:techtime/Screens/company/company_main_screen.dart';

import 'package:techtime/Screens/shared/aboutUs/about_us.dart';
import 'package:techtime/Screens/shared/aboutUs/follow_us.dart';
import 'package:techtime/Screens/shared/startupViews/client_signup_page.dart';
import 'package:techtime/Widgets/core/gallery_view.dart';

import 'package:techtime/screens/Client/contact/contact_us.dart';
import 'package:techtime/screens/Client/profileEdit/profile_edit.dart';
import 'package:techtime/screens/shared/ConnectivityView/network_sensitive.dart';
import 'package:techtime/screens/shared/notifications/notifications.dart';
import 'package:techtime/screens/shared/search_screen.dart';
import 'package:techtime/screens/shared/startupViews/emailForgetPassworProcess/email_confirm_code.dart';
import 'package:techtime/screens/shared/startupViews/emailForgetPassworProcess/email_forget_password.dart';
import 'package:techtime/screens/shared/startupViews/loginScreen/login_page.dart';

import 'Screens/Client/branchProfile/branch_profile.dart';
import 'Screens/Client/reservations/TableReservation/table_reservation.dart';
import 'Screens/Client/reservations/reservationFirstStep/reservation_first_step.dart';
import 'Screens/shared/startupViews/splash_screen_page.dart';
import 'screens/Client/Categories/client_categories_screen.dart';
import 'screens/Client/CategoryCompanies/category_companies.dart';
import 'screens/Client/companyProfile/company_profile.dart';
import 'screens/Client/home_page.dart';
import 'screens/shared/startupViews/language_selection_page.dart';
import 'screens/shared/startupViews/login_moderator_page.dart';
import 'screens/shared/startupViews/sms_verification_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LanguageSelectionPage.routeName:
        return PageTransition(
            type: PageTransitionType.leftToRight,
            duration: const Duration(milliseconds: 600),
            child: NetworkSensitive(child: LanguageSelectionPage()));
      case '/loginModerator':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: LoginModeratorPage(),
        );
      case LoginPage.routeName:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
          child: LoginPage(),
        );
      case ClientSignupPage.routeName:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
          child: ClientSignupPage(),
        );
      case '/sms':
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 400),
          child: SmsVerification(),
        );
      case ClientHomePage.routeName:
        return PageTransition(
          type: PageTransitionType.fade,
          child: NetworkSensitive(child: ClientHomePage()),
        );
      case ClientCategoriesScreen.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => ClientCategoriesScreen(
            isCloseable: args as bool,
          ),
        );
      case '/CompaniesListPage':
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => CategoryCompaniesScreen(
            category: args as Category,
          ),
        );

      case CompanyMainScreen.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => CompanyMainScreen(),
        );
      case CompanyProfile.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => CompanyProfile(
            company: args as Company,
          ),
        );
      case GalleryView.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => GalleryView(
            imgList: (args as Map)["imgList"] as List<String>,
            companyName: args["companyName"] as String,
          ),
        );
      case BranchProfile.routeName:
        return CupertinoPageRoute(
            builder: (_) => BranchProfile(
                  branche: args as CompanyBranche?,
                ));
      case ReservationFirstStep.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => ReservationFirstStep(
            companyBranches: args["CompanyBranches"] as List<CompanyBranche>?,
            reservationType: args["ReservationType"] as ReservationType?,
            branchID: args["branchID"] as int?,
            selectedServices: args["services"] as List<CompanyService>,
          ),
        );
      case TableReservation.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => const TableReservation(),
        );
      case SearchScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => SearchScreen());
      case Notifications.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (_) => Notifications(
                  notifications: args as AllNotifications,
                ));
      case FavoritesScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => const FavoritesScreen());
      case OffersScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => OffersScreen());

      case CompanyOffersScreen.routeName:
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => CompanyOffersScreen(
                  companyOffer: args as CompanyDataOffer?,
                ));
      case ContactUS.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => ContactUS());
      case AboutUsScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => const AboutUsScreen());
      case FollowUsScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => const FollowUsScreen());
      case EmailForgetPassword.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => EmailForgetPassword());
      case EmailConfirmCode.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => EmailConfirmCode(
            emailAddress: args as String,
          ),
        );
      case ProfileEdit.routeName:
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300),
            child: const ProfileEdit());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
