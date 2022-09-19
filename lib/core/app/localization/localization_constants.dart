import 'package:flutter/material.dart';

class LocalizationConstants {
  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const LANG_PATH = "assets/translations";

  static const SUPPORTED_LOCALES = [
    LocalizationConstants.TR_LOCALE,
    LocalizationConstants.EN_LOCALE
  ];
}
