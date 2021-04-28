import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/blocs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/blocs/client/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Helpers/localization/app_language_model.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';
import 'package:techtime/route_generator.dart';

import 'Controllers/blocs/client/ads_bloc/ads_bloc.dart';
import 'Controllers/blocs/client/categorisBloc/categories_bloc.dart';
import 'Controllers/blocs/client/companiesListBloc.dart/companieslist_bloc.dart';
import 'Controllers/blocs/client/companyProfileBloc/company_profile_bloc.dart';
import 'Controllers/blocs/core/Auth/authantication_bloc.dart';
import 'Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'Controllers/cubits/NetworkCubit/internet_cubit.dart';
import 'Controllers/repositories/authentication_repository.dart';
import 'Controllers/repositories/client/companies/companies_repository.dart';
import 'Controllers/repositories/client/home/user_home_repo.dart';
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
        authenticationRepository: AuthenticationRepository(),
      )));
}

class MyApp extends StatelessWidget {
  final RouteGenerator appRouter;
  final Connectivity connectivity;

  final AuthenticationRepository authenticationRepository;

  const MyApp({
    Key key,
    this.appRouter,
    this.connectivity,
    this.authenticationRepository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/background.png"), context);
    precacheImage(AssetImage("assets/images/splashscreen.png"), context);
    APIClientHomeRepository apiClientHomeRepository = APIClientHomeRepository();
    APICompaniesRepository apiCompaniesRepository = APICompaniesRepository();
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
          BlocProvider(create: (context) => AdsBloc(apiClientHomeRepository)),
          BlocProvider(
              create: (context) => CategoriesBloc(apiClientHomeRepository)),
          BlocProvider(
              create: (context) =>
                  RecommendedcompaniesBloc(apiClientHomeRepository)),
          BlocProvider(
              create: (context) => LeastcompaniesBloc(apiClientHomeRepository)),
          BlocProvider(
              create: (context) => CompanieslistBloc(apiCompaniesRepository)),
          BlocProvider(
              create: (context) => CompanyProfileBloc(apiCompaniesRepository)),
          BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
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
  }
}
