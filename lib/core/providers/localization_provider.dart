import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter_app/i18n/i18n.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

typedef LocaleChangeCallback = void Function(Locale locale);

class LocalizationProvider {
  ///We use gen_i18n,you can use you own localization manager
  ///To st plural strings, use Intl.plural
  static initialize() async {
    final String defaultSystemLocale = Platform.localeName;
    final currentDeviceLocale = supportedLocales.firstWhereOrNull(
        (element) => defaultSystemLocale.contains(element.languageCode));
    await I18n.initialize(
        defaultLocale: currentDeviceLocale ?? currentLocale,
        supportLocales: [const Locale('en'), const Locale('fr')]);
  }

  static Locale get currentLocale => I18n.currentLocate;
  static List<Locale> get supportedLocales => I18n.supportedLocales;
  static I18nDelegate get localeDelegate => const I18nDelegate();
  static updateLocale(Locale locale) async =>
      await I18n.updateLocate(locale).then(
          (value) => onLocaleChanged != null ? onLocaleChanged!(locale) : null);
  static LocaleChangeCallback? onLocaleChanged;
}
