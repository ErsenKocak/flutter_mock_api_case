import 'package:flutter/material.dart';

import 'constants/constants.dart';

class AppTheme {
  var CSBSTheme = ThemeData.light().copyWith(
      primaryColor: kprimaryColor,
      appBarTheme: const AppBarTheme(color: kprimaryColor),
      iconTheme: const IconThemeData(color: kprimaryColor),
      textTheme: ThemeData.light().textTheme.apply(
            displayColor: kprimaryColor,
            fontFamily: 'Montserrat',
          ),
      primaryTextTheme: ThemeData.light().textTheme.apply(
            fontFamily: 'Montserrat',
          ),
      scaffoldBackgroundColor: kscaffoldColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kprimaryColor,
      ));
}
