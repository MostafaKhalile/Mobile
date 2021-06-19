import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/branchEmployeesBloc/brancheemployees_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheOffersBloc/brancheoffers_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheProfileBloc/branche_profile_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheReviewsBloc/branchereviews_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/brancheBlocs/brancheServicesBloc/brancheservices_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/companyDataBlocs/companyServicesBloc/companyservices_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/companyProfileBloc/company_profile_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_passwod_bloc/editpassword_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_profile_picture_Bloc/editprofilepicture_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_points_to_price_bloc/walletpointstoprice_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_total_data_bloc/wallet_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_transform_points_blob/wallettransformpoints_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_transform_promocode_bloc/wallettransformpromocode_bloc.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Controllers/Repositories/client/companies/companies_repository.dart';
import 'package:techtime/Controllers/blocs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/blocs/client/profileBloc/profile_bloc.dart';
import 'package:techtime/Controllers/blocs/client/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Helpers/localization/app_language_model.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';
import 'package:techtime/route_generator.dart';

import 'Controllers/BLoCs/client/profile_edit_blocs/edit_cover_bloc/editcover_bloc.dart';
import 'Controllers/BLoCs/client/profile_edit_blocs/edit_mobile_bloc/editmobile_bloc.dart';
import 'Controllers/Cubits/LocaleCubit/locale_cubit.dart';
import 'Controllers/Repositories/client/Account/repository.dart';
import 'Controllers/blocs/client/ads_bloc/ads_bloc.dart';
import 'Controllers/blocs/client/categorisBloc/categories_bloc.dart';
import 'Controllers/blocs/client/companiesListBloc.dart/companieslist_bloc.dart';
import 'Controllers/blocs/client/profile_edit_blocs/edit_email_bloc/editemailaddress_bloc.dart';
import 'Controllers/blocs/client/profile_edit_blocs/edit_first_name_bloc/editfirstname_bloc.dart';
import 'Controllers/blocs/client/profile_edit_blocs/edit_second_name_bloc/editsecondname_bloc.dart';
import 'Controllers/blocs/core/Auth/authantication_bloc.dart';
import 'Controllers/Cubits/NetworkCubit/internet_cubit.dart';
import 'Controllers/Providers/current_user_provider.dart';
import 'Controllers/Repositories/client/home/user_home_repo.dart';
import 'Helpers/APIUrls.dart';
import 'Helpers/localization/app_localizations_delegates.dart';
import 'Helpers/shared_perfs_provider.dart';
import 'Helpers/utils/app_bloc_observer.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceUtils.init();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  AppLanguage().fetchLocale;
  Bloc.observer = AppBlocObserver();
  runApp(ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(),
      child: MyApp(
        appRouter: RouteGenerator(),
        connectivity: Connectivity(),
      )));
}

class MyApp extends StatelessWidget {
  final RouteGenerator appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key key,
    this.appRouter,
    this.connectivity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/background.png"), context);
    precacheImage(AssetImage("assets/images/splashscreen.png"), context);
    APIClientHomeRepository apiClientHomeRepository = APIClientHomeRepository();
    APICompaniesRepository apiCompaniesRepository = APICompaniesRepository();
    BranchesRepository apiBranchesRepository = BranchesRepository();
    USerRepo userRepo = USerRepo();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CurrentUserProvider>(
              create: (context) => CurrentUserProvider()..loadCurrentUser()),
        ],
        child: Builder(builder: (context) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<InternetCubit>(
                  create: (internetCubitContext) =>
                      InternetCubit(connectivity: connectivity),
                ),
                BlocProvider(
                    create: (_) => AuthanticationBloc(
                          authRepo: AuthRepo(),
                        )),
                BlocProvider(create: (context) => ProfileBloc(userRepo)),
                BlocProvider(create: (context) => EditfirstnameBloc(userRepo)),
                BlocProvider(create: (context) => EditLastnameBloc(userRepo)),
                BlocProvider(create: (context) => EditmobileBloc(userRepo)),
                BlocProvider(create: (context) => EditpasswordBloc(userRepo)),
                BlocProvider(create: (context) => WalletBloc(userRepo)),
                BlocProvider(
                    create: (context) => WallettransformpointsBloc(userRepo)),
                BlocProvider(
                    create: (context) => WalletpointstopriceBloc(userRepo)),
                BlocProvider(
                    create: (context) =>
                        WallettransformpromocodeBloc(userRepo)),
                BlocProvider(
                    create: (context) => EditprofilepictureBloc(userRepo)),
                BlocProvider(create: (context) => EditcoverBloc(userRepo)),
                BlocProvider(
                    create: (context) => EditemailaddressBloc(userRepo)),
                BlocProvider(
                    create: (context) => AdsBloc(apiClientHomeRepository)),
                BlocProvider(
                    create: (context) =>
                        CategoriesBloc(apiClientHomeRepository)),
                BlocProvider(
                    create: (context) =>
                        RecommendedcompaniesBloc(apiClientHomeRepository)),
                BlocProvider(
                    create: (context) =>
                        CompanyservicesBloc(apiCompaniesRepository)),
                BlocProvider(
                    create: (context) =>
                        BrancheservicesBloc(apiBranchesRepository)),
                BlocProvider(
                    create: (context) =>
                        BrancheemployeesBloc(apiBranchesRepository)),
                BlocProvider(
                    create: (context) =>
                        BranchereviewsBloc(apiBranchesRepository)),
                BlocProvider(
                    create: (context) =>
                        BrancheOffersBloc(apiBranchesRepository)),
                BlocProvider(
                    create: (context) =>
                        LeastcompaniesBloc(apiClientHomeRepository)),
                BlocProvider(
                    create: (context) =>
                        CompanieslistBloc(apiCompaniesRepository)),
                BlocProvider(
                    create: (context) =>
                        CompanyProfileBloc(apiCompaniesRepository)),
                BlocProvider(
                    create: (context) =>
                        BrancheProfileBloc(apiBranchesRepository)),
                BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
              ],
              child: BlocBuilder<LocaleCubit, LocaleState>(
                buildWhen: (previousState, currentState) =>
                    previousState != currentState,
                builder: (_, localeState) {
                  return MaterialApp(
                      locale: localeState.locale,
                      supportedLocales: [
                        Locale('en', 'US'),
                        Locale('ar', ''),
                      ],
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      title: KAppName,
                      theme: Provider.of<ThemeModel>(context).currentTheme,
                      initialRoute: '/',
                      onGenerateRoute: appRouter.generateRoute);
                },
              ));
        }));
  }
}
