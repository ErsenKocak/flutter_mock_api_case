import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/app/constants/routes.dart';
import 'core/app/theme.dart';
import 'core/init/locator.dart';
import 'cubit/person_detail_cubit/person_detail_cubit.dart';
import 'cubit/person_detail_cubit/person_identifier_cubit/person_identifier_cubit.dart';
import 'cubit/person_list_cubit/person_list_cubit.dart';
import 'view/login/login_view.dart';
import 'view/login/person/person_detail_view/person_detail_view.dart';
import 'view/login/person/person_list_view/person_list_view.dart';

class FlutterCaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PersonListCubit(),
        ),
        BlocProvider(
          create: (context) => PersonDetailCubit(),
        ),
        BlocProvider(
          create: (context) => PersonIdentifierCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Case',
        debugShowCheckedModeBanner: false,
        theme: getIt<AppTheme>().CSBSTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: EasyLoading.init(),
        routes: {
          LOGIN_ROUTENAME: (context) => (LoginView()),
          PERSON_LIST_ROUTE_NAME: (context) => (const PersonListView()),
          PERSON_DETAIL_ROUTE_NAME: (context) => (PersonDetailView(
                isDetail: false,
              )),
        },
        initialRoute: LOGIN_ROUTENAME,
      ),
    );
  }
}
