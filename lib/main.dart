import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:techtime/data/repositories/user_home_repo.dart';
import 'package:techtime/logic/blocs/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/presentation/route_generator.dart';
import 'constants/app_consts.dart';
import 'data/models/AppConfgModels/app_localizations_delegates.dart';
import 'data/models/AppConfgModels/theme_model.dart';
import 'logic/blocs/ads_bloc/ads_bloc.dart';
import 'logic/blocs/categorisBloc/categories_bloc.dart';
import 'logic/blocs/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'logic/cubit/LocaleCubit/locale_cubit.dart';

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
