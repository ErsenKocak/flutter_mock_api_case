import '../../core/init/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:logger/logger.dart';

import 'widgets/sign_in_form/sign_in_form.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(flex: 2),
              Expanded(
                flex: 5,
                child: buildLogoContainer(),
              ),
              const Spacer(),
              Expanded(
                flex: 12,
                child: buildSignInFormContainer(),
              ),
              const Spacer(),
            ],
          )),
    );
  }

  buildLogoContainer() {
    return Image.asset('assets/images/login/login_logo_transparent.png');
  }

  buildSignInFormContainer() {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(), child: SignForm());
  }
}
