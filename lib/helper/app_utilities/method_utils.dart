import 'dart:io';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../dxWidget/dx_text.dart';
import '../localStorage/preference_handler.dart';
import 'app_theme.dart';

class MethodUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static void toast(String name) {
    Fluttertoast.showToast(
        msg: name,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static Future<String> datePicker(
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    final picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: materialAccentColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: materialAccentColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: navigatorKey.currentContext!,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      return picked.toString();
    }

    print("date and time $picked");
    return "";
  }

  static String generateOTPInRange() {
    int min = 100000;
    int max = 999999;
    if (min >= max) {
      throw ArgumentError("Min must be less than max");
    }
    Random random = Random();
    // Generate a random number within the specified range
    int otp = min + random.nextInt(max - min);
    return otp.toString();
  }

  static String getCurrTimestamp({bool includeMillisecond = true}) {
    DateTime now = DateTime.now();
    return includeMillisecond
        ? "${now.day}${now.month}${now.year}${now.hour}${now.minute}${now.second}${now.millisecond}"
        : "${now.day}${now.month}${now.year}${now.hour}${now.minute}${now.second}";
  }

  static String getFormattedCustomDate(
    String date,
    String inputDateFormat,
    String outputDateFormat,
  ) {
    /// Remove leading/trailing whitespace before parsing (prevents format errors)
    date = date.trim();

    try {
      /// Parse the date string using DateTime.parse()
      var inputFormat = DateFormat(inputDateFormat);
      var inputDate = inputFormat.parse(date);

      /// Format the date using DateFormat()
      var outputFormat = DateFormat(outputDateFormat);
      var outputDate = outputFormat.format(inputDate);

      return outputDate;
    } on FormatException catch (e) {
      // Handle parsing errors gracefully (e.g., log the error or return a default value)
      print("Error parsing date: $e");
      return ""; // Or return a default date string or widget
    }
  }

  // static void showSnackBar(BuildContext ctx, msgToDisplay) {
  //   print(msgToDisplay);
  //
  //   var snackBar = SnackBar(
  //     content: Text(msgToDisplay),
  //   );
  //
  //   // Scaffold.of(ctx).showSnackBar(snackBar);
  // }
  //
  // static void showSnackBarGK(GlobalKey<ScaffoldState> globalScaffoldKey, msgToDisplay) {
  //   print(msgToDisplay);
  //
  //   var snackBar = SnackBar(content: Text(msgToDisplay));
  //
  //   // globalScaffoldKey.currentState!.showSnackBar(snackBar);
  // }

  static String getGreetingText() {
    String wText = "";
    DateTime c = DateTime.now();
    int timeOfDay = c.hour;

    if (timeOfDay >= 0 && timeOfDay < 12) {
      wText = "Good Morning";
    } else if (timeOfDay >= 12 && timeOfDay < 16) {
      wText = "Good Afternoon";
    } else if (timeOfDay >= 16 && timeOfDay < 21) {
      wText = "Good Evening";
    } else if (timeOfDay >= 21 && timeOfDay < 24) {
      wText = "Good Night";
    }
    return wText;
  }

  static ButtonStyle raisedButtonStyle(Color color, {double radius = 6.0}) =>
      ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      );

  static void showAlertDialog(
      BuildContext context, String mTitle, String mContent,
      {Function()? callback}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new DxTextBlack(
            mTitle,
            mSize: 22,
            mBold: true,
            textAlign: TextAlign.center,
          ),
          content: new DxTextBlack(mContent,
              maxLine: 3, textAlign: TextAlign.center, mSize: 20),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       width: 75,
            //       color: materialAccentColor,
            //       child: new TextButton(
            //         child: new DxTextWhite(
            //           "Yes",
            //           mBold: true,
            //         ),
            //         onPressed: callback,
            //       ),
            //     ),
            //     Container(
            //       width: 75,
            //       color: Colors.grey,
            //       child: new TextButton(
            //         child: new DxTextWhite(
            //           "No",
            //           mBold: true,
            //         ),
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ),
            //   ],
            // )

            Center(
              child: Container(
                width: 75,
                child: new TextButton(
                  style: MethodUtils.raisedButtonStyle(materialPrimaryColor),
                  child: new DxTextWhite(
                    "Ok",
                    mBold: true,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showCommonDialog(
      BuildContext context, String mTitle, String mContent,
      {Function()? callback}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          //this right here
          child: Container(
            height: 160,
            width: 250,
            decoration: BoxDecoration(
                border: Border.all(color: materialPrimaryColor),
                borderRadius: BorderRadius.circular(12.0)),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: DxTextBlack(
                    mTitle,
                    mBold: true,
                    mSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: DxTextBlack(
                    mContent,
                    mBold: true,
                    maxLine: 3,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        color: materialPrimaryColor,
                        child: TextButton(
                          // style: raisedButtonStyle(materialPrimaryColor),
                          onPressed: callback,
                          child: DxTextWhite(
                            "Ok",
                            mBold: true,
                          ),
                        ),
                        height: 35,
                        width: 70,
                      ),
                    ),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    // Expanded(
                    //   child: Container(
                    //     color: Colors.grey,
                    //     child: TextButton(
                    //       onPressed: (){
                    //         Navigator.pop(context);
                    //       },
                    //       child: DxTextWhite("No",mBold: true,),
                    //     ),
                    //     height: 35,
                    //     width: 70,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showCommonDialog2(
      BuildContext context, String mTitle, String mContent,
      {Function()? callback}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          //this right here
          child: Container(
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(color: materialPrimaryColor),
                borderRadius: BorderRadius.circular(12.0)),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: DxTextBlack(
                    mTitle,
                    mBold: true,
                    mSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: DxTextBlack(
                    mContent,
                    mBold: true,
                    maxLine: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        onPressed: callback,
                        child: DxTextWhite(
                          "Upload",
                          mSize: 18,
                          mBold: true,
                        ))),

                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: raisedButtonStyle(Colors.grey.shade50),
                        child: DxTextBlack(
                          "Cancel",
                          mSize: 18,
                          mBold: true,
                        ))),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Expanded(
                //       child: Container(
                //         color: materialPrimaryColor,
                //         child: TextButton(
                //           // style: raisedButtonStyle(materialPrimaryColor),
                //           onPressed: callback,
                //           child: DxTextWhite("Ok",mBold: true,),
                //         ),
                //         height: 35,
                //         width: 70,
                //       ),
                //     ),
                //
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showConfirmDialog(BuildContext context, String mTitle,
      String mContent, Function callback(bool)) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(mTitle),
          content: new Text(mContent),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: new Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
                callback(false);
              },
            ),
            TextButton(
              child: new Text("YES"),
              onPressed: () {
                Navigator.of(context).pop();
                callback(true);
              },
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialogCupertino(
      BuildContext context, String mTitle, String mContent, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => new CupertinoAlertDialog(
        title: new Text(mTitle),
        content: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            mContent,
          ),
        ),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(ctx);
                callback();
                // Navigator.pop(context);
              },
              isDefaultAction: true,
              child: new Text("OK"))
        ],
      ),
    );
  }

  static void showAlertDialogWithParameter(
      BuildContext context, String mTitle, var mVarData, Function callback) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(mTitle),
          content: new Text("subtitle"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                callback(context, mVarData);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> isInternetPresentOld() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //  print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      //print('not connected');
      return false;
    }
  }

  static Future<bool> isInternetPresent() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        print("Connected to Mobile Network");

        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        print("Connected to WiFi");
        return true;
      } else {
        print("Unable to connect. Please Check Internet Connection");
        return false;
      }
    } on SocketException catch (_) {
      //print('not connected');
      return false;
    }
  }

  static Future<void> askMultiplePermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.camera,
      ].request();
    } on SocketException catch (_) {
      //print('not connected');
    }
  }

  static Future<void> askLocationPermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
    } on SocketException catch (_) {
      //print('not connected');
    }
  }

  static void showSessionTimeoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: DxTextBlack(
              'Session Timeout',
              mSize: 18,
              mBold: true,
            ),
            content: DxTextBlack(
              'Your session has timed out. Please log in again.',
              maxLine: 4,
            ),
            actions: [
              ElevatedButton(
                child: DxTextWhite(
                  'Ok',
                  mSize: 18,
                  mBold: true,
                ),
                onPressed: () {
                  // Navigate to the login page or perform other actions
                  PreferenceHandler.logout(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
