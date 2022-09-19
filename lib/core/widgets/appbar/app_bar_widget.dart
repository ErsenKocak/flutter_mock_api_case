import 'package:flutter/material.dart';

import '../../app/constants/constants.dart';
import '../custom_icon_button/custom_icon_button.dart';

appBarWidget(height, context, title, GlobalKey<ScaffoldState>? scaffolKey,
        List<Widget>? actions, CustomIconButton? leadingIcon) =>
    PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, (height + 65)),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            height: height + 40,
            width: MediaQuery.of(context).size.width,
            // Background
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [],
              ),
            ),
          ),
          Container(),
          Positioned(
            top: 60.0,
            left: 20.0,
            right: 20.0,
            child: AppBar(
              toolbarHeight: 60,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                  bottom: Radius.circular(20),
                ),
              ),
              leading: leadingIcon,

              title: Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: kprimaryColor),
                ),
              ),

              // title: Center(
              //   child: Text(title,
              //       style: TextStyle(
              //           fontSize: 36.sp,
              //           fontWeight: FontWeight.w500,
              //           color: Theme.of(context).primaryColor)),
              // ),
              backgroundColor: Colors.white,
              primary: false,
              actions: actions ?? [SizedBox()],
            ),
          )
        ],
      ),
    );
