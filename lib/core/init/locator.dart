import 'package:flutter_mock_api_case_ersen_kocak/core/app/theme.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/helper/date_time_formatter_helper/date_formatter_helper.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/helper/mask_formatter_helper/mask_formatter_helper.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/helper/toast_helper/toast_helper.dart';
import 'package:flutter_mock_api_case_ersen_kocak/service/person/person_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../app/constants/constants.dart';
import '../helper/dialog_helper/dialog_helper.dart';
import '../helper/identifier_helper/identifier_helper.dart';

final getIt = GetIt.instance;

setupLocator() {
  //NETWORK
  getIt.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: BASE_URL!,
      contentType: 'application/json',
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000)));

//THEME
  getIt.registerSingleton<AppTheme>(AppTheme());

  //LOG
  getIt.registerSingleton<Logger>(Logger());

  //HELPER
  getIt.registerSingleton<DateFormatterHelper>(DateFormatterHelper());
  getIt.registerSingleton<DialogHelper>(DialogHelper());
  getIt.registerSingleton<ToastHelper>(ToastHelper());
  getIt.registerSingleton<IdentifierHelper>(IdentifierHelper());
  getIt.registerSingleton<MaskFormatterHelper>(MaskFormatterHelper());

  //SERVICE
  getIt.registerSingleton<PersonService>(PersonService());
}
