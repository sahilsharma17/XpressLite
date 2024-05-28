import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../main.dart';
import 'app_routes.dart';
import 'navigatorAnimation.dart';

//=============================================================================



void openScreenAsLeftToRight( Widget targetWidget) => openScreenAsPlatformWiseRoute( targetWidget, isFullScreen: false);

//=============================================================================

Future<void> openScreenAsBottomToTop( Widget targetWidget, {bool isFullScreen = false}) async => await Navigator.of(navigatorKey.currentContext!).push(AppRoute.createRoute(targetWidget, isFullScreen: isFullScreen));
//=============================================================================

Future<void> openScreenAsScale( Widget targetWidget, {bool isFullScreen = false}) async => await Navigator.of(navigatorKey.currentContext!).push(
      Transitions(transitionType: TransitionType.scale, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut, reverseCurve: Curves.fastOutSlowIn, widget: targetWidget),
    ); //=============================================================================

Future<void> openScreenForDrawer(Widget targetWidget, {bool isFullScreen = false}) async => await Navigator.of(navigatorKey.currentContext!).push(
      Transitions(transitionType: TransitionType.fade, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut, reverseCurve: Curves.fastOutSlowIn, widget: targetWidget),
    );
//=============================================================================

Future<void> openScreenAfterLogin( Widget targetWidget, {bool isFullScreen = false}) async => await Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      Transitions(transitionType: TransitionType.size, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut, reverseCurve: Curves.fastOutSlowIn, widget: targetWidget),
      (route) => false,
    );

//Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => targetWidget));

//=============================================================================

Future<dynamic> openScreenAsPlatformWiseRoute( Widget targetWidget, {bool isFullScreen = false, bool isExit = false, TransitionType? transitionType}) async => isExit
    ? (!kIsWeb && Platform.isIOS
        ? Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (BuildContext context) => targetWidget,
            ),
            (route) => false)
        : Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => targetWidget,
            ),
            (route) => false))
    : (!kIsWeb && Platform.isIOS
        ? Navigator.of(navigatorKey.currentContext!).push(CupertinoPageRoute(
            builder: (BuildContext context) => targetWidget,
          ))
        : Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
            builder: (BuildContext context) => targetWidget,
          )));

//////////////////////=====================NAVIGATOR2.0----------------------//////////////////////////////////

abstract class AppRoutes {
  static const splash = '/splash';
  static const login = '/auth-login';
  static const verifyOTP = '/verify-otp';
  static const sclass = '/class';
  static const bottomNavigation = '/bottomNavigation';
  static const registration = '/registration-page';
  static const settingsPage = '/settings-page';
  static const mediaTypePage = '/media-type-page';
  static const editProfilePage = '/edit-profile-page';
  static const fcmMsg = '/message';
  static const chattingPage = '/chatting-Page';
  static const feedUserDetailsPage = '/feed-user-details-Page';
}

//--------------------------- Platform specific route -----------------------------------

_platformWisePage(Widget page, bool fullScreenDialog) {
  try {
    return Platform.isIOS ? CupertinoPageRoute(builder: (_) => page, fullscreenDialog: fullScreenDialog) : MaterialPageRoute(builder: (_) => page, fullscreenDialog: fullScreenDialog);
  } catch (e) {
    return MaterialPageRoute(builder: (_) => page, fullscreenDialog: fullScreenDialog);
  }
}

//--------------------------- Handling On generate Routes. ------------------------------
