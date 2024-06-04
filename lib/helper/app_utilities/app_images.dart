import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class AppImages {
  static String imageExt(String path) => "assets/$path";
  static String get applogo => imageExt("appLogo.png");
  static String get loader => imageExt("Loader.gif");
  static String get background => imageExt("background1.jpg");
  static String get form => imageExt("form1.png");
  static String get report => imageExt("report1.png");
  static String get location => imageExt("location.gif");
  static String get locationRefresh => imageExt("locationRefresh.png");
  static String get accessDenied => imageExt("analysis.png");
  static String get dashboard => imageExt("dashboard.jpg");
  static String get dashboard1 => imageExt("dashboard1.png");
  static String get cameraRemark => imageExt("camera.png");
  static String get textRemark => imageExt("text.png");
  static String get questionSync => imageExt("sync.png");
  static String get employee => imageExt("attendance.png");
  static String get iconImage => imageExt("DemoIcon.png");
  static String get pecsIconImage => imageExt("pecs.jpeg");



  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
