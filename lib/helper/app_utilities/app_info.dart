import 'package:flutter/foundation.dart';

class AppInfo {
  static const String companyName = "CBTECH";
  static const String companyAddress =
      "810 & 910, B Wing, Samartha Aishwarya, Off New Link Road, Opp Highland Park Coop Society, Andheri (W), Mumbai, Maharastra 400053\nPh- 022 26300106";
  static const String appName = "EHS25 HR INDIA PVT LTD";
  static const String appVersion = "1.0.0";
  static const String appVersionDisplay = "20200908";
  // static const String allRightReserved =
  //     "© 2020 \n CBO Infotech Private Limited \nAll Rights Reserved.";

  static const String _ANDROID = "ANDROID";
  static const String _IOS = "IOS";

  static String getPlatform() =>
      defaultTargetPlatform == TargetPlatform.android ? _ANDROID : _IOS;
}
