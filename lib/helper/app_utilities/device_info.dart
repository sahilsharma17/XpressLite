//import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  static isDeviceIOS() => defaultTargetPlatform == TargetPlatform.iOS;

  static useMobileLayout(BuildContext context) => MediaQuery.of(context).size.shortestSide < 600;

  static useLayoutNormal(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 320 && MediaQuery.of(context).size.shortestSide < 600;

  static useLayoutExtraSmall(BuildContext context) => MediaQuery.of(context).size.shortestSide <= 320;

  static useLayoutMiddle(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 320 && MediaQuery.of(context).size.shortestSide < 500;

  static getDeviceIMEI() async => "123456789";

  static String getDeviceType() => isDeviceIOS() ? "IOS" : "ANDROID";

  // static getDeviceName() => "";


}


class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}