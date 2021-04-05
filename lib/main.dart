import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/blocs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/blocs/client/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/Helpers/localization/app_language_model.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';
import 'package:techtime/route_generator.dart';

import 'Controllers/blocs/client/ads_bloc/ads_bloc.dart';
import 'Controllers/blocs/client/categorisBloc/categories_bloc.dart';
import 'Controllers/blocs/client/companiesListBloc.dart/companieslist_bloc.dart';
import 'Controllers/blocs/client/companyProfileBloc/company_profile_bloc.dart';
import 'Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'Controllers/cubits/NetworkCubit/internet_cubit.dart';
import 'Controllers/repositories/client/companies/companies_repository.dart';
import 'Controllers/repositories/client/home/user_home_repo.dart';
import 'Helpers/APIUrls.dart';
import 'Helpers/localization/app_localizations_delegates.dart';
import 'Helpers/utils/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  const MyApp({Key key, this.appRouter, this.connectivity}) : super(key: key);
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
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        ));
  }
}
