import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:techtime/data/repositories/user_home_repo.dart';
import 'package:techtime/logic/blocs/recommendedCompaniesBloc/recommendedcompanies_bloc.dart';
import 'package:techtime/logic/cubit/theme_cubit.dart';
import 'package:techtime/presentation/route_generator.dart';
import 'constants/app_consts.dart';
import 'data/models/AppConfgModels/app_language_model.dart';
import 'data/models/AppConfgModels/app_localizations_delegates.dart';
import 'data/models/AppConfgModels/theme_model.dart';
import 'logic/blocs/ads_bloc/ads_bloc.dart';
import 'logic/blocs/categorisBloc/categories_bloc.dart';
import 'logic/blocs/leastCompaniesBloc/leastcompanies_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(),
      child: MyApp(
        appLanguage: appLanguage,
      )));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/background.png"), context);
    precacheImage(AssetImage("assets/images/splashscreen.png"), context);
    APIClientHomeRepository apiClientHomeRepository = APIClientHomeRepository();
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MultiBlocProvider(
              providers: [
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
                        LeastcompaniesBloc(apiClientHomeRepository)),
              ],
              child: MaterialApp(
                locale: model.appLocal,
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
              ));
        }));
  }
}
