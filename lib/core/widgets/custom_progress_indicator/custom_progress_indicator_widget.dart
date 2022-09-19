import 'package:flutter/material.dart';

import '../../app/constants/constants.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(color: ksecondaryColor, strokeWidth: 2),
    ));
  }
}
