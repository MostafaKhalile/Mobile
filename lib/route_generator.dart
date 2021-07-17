import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techtime/Models/client/category.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/Models/client/companyProfile/company_branches.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';
import 'package:techtime/Screens/Client/Offres/all_companies_offers_screen.dart';
import 'package:techtime/Screens/Client/favorites/favorites_screen.dart';

import 'package:techtime/Screens/Core/aboutUs/about_us.dart';
import 'package:techtime/Screens/Core/aboutUs/follow_us.dart';

import 'package:techtime/screens/Client/contact/contact_us.dart';
import 'package:techtime/screens/Client/profileEdit/profile_edit.dart';
import 'package:techtime/screens/Core/ConnectivityView/network_sensitive.dart';
import 'package:techtime/screens/Core/notifications/notifications.dart';
import 'package:techtime/screens/Core/search_screen.dart';
import 'package:techtime/screens/Core/startupViews/emailForgetPassworProcess/email_confirm_code.dart';
import 'package:techtime/screens/Core/startupViews/emailForgetPassworProcess/email_forget_password.dart';
import 'package:techtime/screens/Core/startupViews/loginScreen/login_page.dart';
import 'package:techtime/screens/company/company_placeholder.dart';
import 'package:techtime/widgets/core/gallery_view.dart';

import 'Screens/Client/branchProfile/branch_profile.dart';
import 'Screens/Client/reservations/TableReservation/table_reservation.dart';
import 'Screens/Client/reservations/reservationFirstStep/reservation_first_step.dart';
import 'Screens/Core/startupViews/splash_screen_page.dart';
import 'screens/Client/Categories/client_categories_screen.dart';
import 'screens/Client/CategoryCompanies/category_companies.dart';
import 'screens/Client/companyProfile/company_profile.dart';
import 'screens/Client/home_page.dart';
import 'screens/Core/startupViews/client_signup_page.dart';
import 'screens/Core/startupViews/language_selection_page.dart';
import 'screens/Core/startupViews/login_moderator_page.dart';
import 'screens/Core/startupViews/sms_verification_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

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

      case CompanyPlaceholder.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => CompanyPlaceholder(),
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
            companyName: (args as Map)["companyName"] as String,
          ),
        );
      case BranchProfile.routeName:
        return CupertinoPageRoute(
            builder: (_) => BranchProfile(
                  branche: args as CompanyBranche,
                ));
        break;
      case ReservationFirstStep.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => ReservationFirstStep(
            companyBranches: args as List<CompanyBranche>,
          ),
        );
        break;
      case TableReservation.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => const TableReservation(),
        );
        break;
      case SearchScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => SearchScreen());
        break;
      case Notifications.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (_) => Notifications(
                  notifications: args as AllNotifications,
                ));
        break;
      case FavoritesScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => const FavoritesScreen());
        break;
      case OffersScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => OffersScreen());
        break;

      case ContactUS.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => ContactUS());
        break;
      case AboutUsScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => const AboutUsScreen());
        break;
      case FollowUsScreen.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => const FollowUsScreen());
        break;
      case EmailForgetPassword.routeName:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => EmailForgetPassword());
        break;
      case EmailConfirmCode.routeName:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => EmailConfirmCode(
            emailAddress: args as String,
          ),
        );
        break;
      case ProfileEdit.routeName:
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300),
            child: const ProfileEdit());
        break;
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
