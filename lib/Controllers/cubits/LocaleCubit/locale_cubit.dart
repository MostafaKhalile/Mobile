import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:meta/meta.dart';
import 'package:techtime/Helpers/localization/app_language_model.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  // Passing an initial value (state) with a default 'Locale' to the super class.
  LocaleCubit() : super(SelectedLocale(AppLanguage().appLocal));

  // Once we call this method, the BlocBuilder<LocaleCubit>
  // in the 'main.dart' will rebuild the entire app with
  // the new emitted state that holds the 'ar' locale.
  Future<void> toArabic() async {
    print("to Arabic");
    emit(const SelectedLocale(Locale('ar')));
    AppLanguage().changeLanguage(const Locale('ar'));
  }

  // Same as the previous method, but with the 'en' locale.
  void toEnglish() {
    emit(const SelectedLocale( Locale('en')));
    AppLanguage().changeLanguage(const Locale('en'));
  }
}
