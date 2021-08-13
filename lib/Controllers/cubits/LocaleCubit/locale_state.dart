part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {
  final Locale? locale;
  const LocaleState(this.locale);
}

class SelectedLocale extends LocaleState {
  final Locale? userLocale;
  const SelectedLocale(this.userLocale) : super(userLocale);
}
