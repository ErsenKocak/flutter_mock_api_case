import 'package:easy_localization/easy_localization.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'core/app/localization/localization_constants.dart';
import 'core/config/easy_loading/easy_loading_config.dart';
import 'core/init/locator.dart';
import 'flutter_case_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Flavor.create(
    Environment.dev,
    properties: {
      'applicationId': 'neyasis.case.dev',
      'applicationName': 'Neyasis Testi',
      'apiBaseUrl': 'https://6325f62170c3fa390f921965.mockapi.io/api/',
      'versionName': '1.0.0',
      'versionCode': '1'
    },
  );
  setupLocator();
  configLoading();

  runApp(EasyLocalization(
      supportedLocales: LocalizationConstants.SUPPORTED_LOCALES,
      path: LocalizationConstants.LANG_PATH,
      fallbackLocale: LocalizationConstants.TR_LOCALE,
      child: FlutterCaseApp()));
}
