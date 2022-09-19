import 'package:flutter/material.dart';

import 'package:ndialog/ndialog.dart';

import '../../app/constants/constants.dart';

class DialogHelper {
  Future showDialog(BuildContext context,
      {String? title, Widget? body, List<Widget>? actions}) async {
    await NDialog(
            dialogStyle: DialogStyle(
                contentPadding: const EdgeInsets.all(8),
                titleDivider: false,
                elevation: 8,
                titlePadding: const EdgeInsets.all(0)),
            title: Container(
              height: 50,
              width: 100,
              color: ksecondaryColor,
              child: Center(
                  child: title != null
                      ? Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .apply(color: Colors.white),
                        )
                      : SizedBox()),
            ),
            content: body,
            actions: actions)
        .show(context);
  }
}
