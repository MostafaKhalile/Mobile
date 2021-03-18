import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/blocs/client/companies_list_bloc.dart/companieslist_bloc.dart';
import 'package:techtime/Controllers/blocs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/blocs/client/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';
import 'package:techtime/route_generator.dart';

import 'Controllers/blocs/client/ads_bloc/ads_bloc.dart';
import 'Controllers/blocs/client/categorisBloc/categories_bloc.dart';
import 'Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'Controllers/repositories/client/companies/companies_repository.dart';
import 'Controllers/repositories/client/home/user_home_repo.dart';
import 'Helpers/APIUrls.dart';
import 'Helpers/localization/app_localizations_delegates.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AppLanguage appLanguage = AppLanguage();
  // await appLanguage.fetchLocale();
  runApp(ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/background.png"), context);
    precacheImage(AssetImage("assets/images/splashscreen.png"), context);
    APIClientHomeRepository apiClientHomeRepository = APIClientHomeRepository();
    APICompaniesRepository apiCompaniesRepository = APICompaniesRepository();
    return MultiBlocProvider(
        providers: [
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
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        ));
  }
}
