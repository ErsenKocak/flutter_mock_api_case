import 'package:flutter/material.dart';

import 'core/config/easy_loading/easy_loading_config.dart';
import 'core/init/locator.dart';
import 'flutter_case_app.dart';
import 'package:flavor/flavor.dart';

void main() {
  print('PROD ÇALIŞTI');
  setupLocator();
  configLoading();
  Flavor.create(
    Environment.production,
    properties: {
      'applicationId': 'neyasis.case.prod',
      'applicationName': 'Neyasis Testi PROD',
      'apiBaseUrl': 'https://6325f62170c3fa390f921965.mockapi.io/api/',
      'versionName': '1.2.0',
      'versionCode': '1.2'
    },
  );
  runApp(FlutterCaseApp());
}
