import 'package:flutter/material.dart';

import 'core/config/easy_loading/easy_loading_config.dart';
import 'core/init/locator.dart';
import 'flutter_case_app.dart';
import 'package:flavor/flavor.dart';

void main() {
  print('DEV ÇALIŞTI');
  setupLocator();
  configLoading();

  runApp(FlutterCaseApp());
}
