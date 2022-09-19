import 'package:flutter/material.dart';

import 'core/config/easy_loading/easy_loading_config.dart';
import 'core/init/locator.dart';
import 'flutter_case_app.dart';
import 'package:flavor/flavor.dart';

void main() {
  print('Test ÇALIŞTI');
  setupLocator();
  configLoading();
  Flavor.create(
    Environment.test,
    properties: {
      'applicationId': 'neyasis.case.test',
      'applicationName': 'Neyasis',
      'apiBaseUrl': 'https://6325f62170c3fa390f921965.mockapi.io/api/',
      'versionName': '3.0.0',
      'versionCode': '3'
    },
  );
  runApp(FlutterCaseApp());
}
