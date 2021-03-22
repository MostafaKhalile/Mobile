part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

class SelectedLocale extends LocaleState {
  final Locale userLocale;
  SelectedLocale(this.userLocale) : super(null);
}
