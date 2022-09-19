import '../../app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 10)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = kprimaryColor
    ..backgroundColor = const Color(0xFFFFFFFF)
    ..indicatorColor = kprimaryColor
    ..textColor = kprimaryColor
    ..maskColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.black
    ..toastPosition = EasyLoadingToastPosition.center
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
