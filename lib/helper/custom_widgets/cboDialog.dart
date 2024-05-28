import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_utilities/app_theme.dart';
import '../app_utilities/dx_app_decoration.dart';
import '../app_utilities/size_reziser.dart';

Future<void> cboDialog(BuildContext context,
    {required Function()? funRESET,
    required String alertTitle,
    required Function()? funSupport,
    required String msg}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: ClipRRect(
          // borderRadius: BorderRadius.circular(4),
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.blue.shade50,
              child: Text(
                alertTitle,
                style: AppStyles.getTextStyleColor(
                    true, getSize(16, dialogContext),
                    textColor: Colors.blue.shade900),
              )),
        ),
        content: Container(padding: EdgeInsets.all(0.0), child: Text(msg)),
        actions: <Widget>[
          TextButton(
              // shape:
              // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
              child: Text(
                "RESET",
                style: TextStyle(color: Colors.grey.shade900),
              ),
              onPressed: funRESET),
          TextButton(
              // shape:
              // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: materialAccentColor)),
              child: Text(
                "SUPPORT",
                style: TextStyle(color: Colors.grey.shade900),
              ),
              onPressed: funSupport),
        ],
      );
    },
  );
}

// Future<bool> commonDialog(BuildContext context, String msg,
//     {Function positiveCallback,
//     Function negativeCallback,
//     bool isSuccess = true,
//     String alertTitle = "Alert!!",
//     String positiveBtnText = "OK",
//     String negativeBtnText = "Cancel",
//     String dcrDate,
//     String dcrId,
//     bool isRedBtnDialog = false}) {
//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext dialogContext) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(12.0))),
//         contentPadding: const EdgeInsets.all(8),
//         titlePadding: const EdgeInsets.all(0),
//         title: ClipRRect(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12), topRight: Radius.circular(12)),
//           child: Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(16),
//               width: double.infinity,
//               color: Colors.white,
//               child: Text(
//                 alertTitle?.toUpperCase(),
//                 style: AppStyles.getTextStyleColor(
//                   true,
//                   getSize(18, dialogContext),
//                   textColor: Colors.black,
//                 ),
//               )),
//         ),
//         content: Container(
//           padding: EdgeInsets.only(top: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: CboTextBlack(
//                     "$msg",
//                     mSize: 16,
//                     mBold: true,
//                   )),
//               SizedBox(
//                 height: 24,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Row(
//                   mainAxisAlignment: negativeCallback != null
//                       ? MainAxisAlignment.end
//                       : MainAxisAlignment.end,
//                   children: [
//                     if (negativeCallback != null)
//                       TextButton(
//                         child: CboTextBlack(
//                           negativeBtnText,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context, false);
//                           negativeCallback();
//                         },
//                       ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     TextButton(
//                         // textColor: primaryColor,
//                         // shape:
//                         // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
//                         child: isRedBtnDialog
//                             ? CboTextRed(
//                                 positiveBtnText,
//                                 mBold: true,
//                               )
//                             : CboTextPrimary(
//                                 positiveBtnText,
//                                 mBold: true,
//                               ),
//                         onPressed: () {
//                           Navigator.pop(context, true);
//                           if (positiveCallback != null) {
//                             positiveCallback();
//                           }
//                         }),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CboText(
//                       "Version: ${AppConfigs().appVersion}",
//                       mSize: 12,
//                       mBold: true,
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (dcrDate != null)
//                           CboText(
//                             "DCR DATE: $dcrDate",
//                             textColor: textBlueDark,
//                             mSize: 12,
//                           ),
//                         if (dcrId != null)
//                           CboText(
//                             "DCR ID: $dcrDate",
//                             textColor: textBlueDark,
//                             mSize: 12,
//                           ),
//                         SizedBox.shrink()
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

/*
* This dialog does not required context, use it to show alerts from cubit wherever required.
* change position in target if required, only position matters.
* uncomment duration to show for durations.
* */

void showDPAlert({required String title, required String bodyText}) {}

// void cboAlert(BuildContext context,
//     {required String title, required String bodyText, Function()? onOkClick, bool isSuccess = false}) {
//   commonDialog(context, bodyText, positiveBtnText: "OK", isSuccess: isSuccess);
// }

class Constants {
  Constants._();

  static const double padding = 8;
  static const double avatarRadius = 35;
}

// void cboAlertV2({bool? isSuccess, String? title, String? descriptions, String? btnText}) {
//   CboToast.showAttachedWidget(
//       attachedBuilder: (context) => CustomDialogBox(
//             isSuccess: isSuccess!,
//             title: title!,
//             descriptions: descriptions!,
//             btnText: btnText!,
//           ),
//       target: Offset(520, 520));
// }

class CustomDialogBox extends StatefulWidget {
  final String? title, descriptions, btnText;
  final bool? isSuccess;
  final Image? img;
  final Function()? onPressed;

  const CustomDialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      this.btnText,
      this.img,
      this.isSuccess,
      this.onPressed})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return Container(
      width: 350,
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            padding: EdgeInsets.only(
                left: Constants.padding,
                top: Constants.avatarRadius + Constants.padding,
                right: Constants.padding,
                bottom: 4),
            margin: EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title??"",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.descriptions??"",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: TextButton(
                      // color: widget.isSuccess! ? Colors.green : primaryRed60,
                      onPressed: widget.onPressed,
                      child: Text(
                        widget.btnText!,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              ],
            ),
          ),

          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: Container(
              // height: Constants.avatarRadius,
              // width: Constants.avatarRadius,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                shape: BoxShape.circle,
                //   boxShadow: [
                //   BoxShadow(
                //       color: Colors.black38, offset: Offset(0, 10), blurRadius: 10),
                // ]
              ),
              child: InkWell(
                onTap: widget.onPressed,
                child: CircleAvatar(
                  backgroundColor: widget.isSuccess! ? Colors.green : primaryRed60,
                  radius: 35,
                  child: widget.isSuccess!
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 25,
                        ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 50,
          //   left: 10,
          //   child: Text("Version : ${AppConfigs().appVersion}", style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),),
          // ),
        ],
      ),
    );
  }
}

//NEW Dialog
// Future commonDialog(BuildContext context, String msg,
//     {Function()? positiveCallback,
//     Function()? negativeCallback,
//     bool isSuccess = true,
//     String alertTitle = "Alert!!",
//     String positiveBtnText = "OK",
//     String negativeBtnText = "Cancel",
//     String? dcrDate,
//     String? dcrId,
//     //for navigation case only.
//     bool doNotPop = false,
//     bool isFCMType = false,
//     bool isRedBtnDialog = false}) async {
//   // final dcrDate = await PreferenceHandler().getDcrDate();
//   // final paID = await PreferenceHandler().getLoginPaId();
//   // final dcrId = await PreferenceHandler().getDcrId();
//
//   RichText richText({String? head, String? val}) => RichText(
//           text: TextSpan(text: head, style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10), children: <TextSpan>[
//         TextSpan(
//             text: val,
//             style: Theme.of(context).textTheme.caption!.copyWith(
//                   color: Colors.grey.shade600,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 10,
//                 ))
//       ]));
//   // bool isInTest = BlocProvider.of<SplashCubit>(context).getTestConfigs.testingStatus;
//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext dialogContext) {
//       print("Working");
//
//       final isTablet = CBOResponsive.isTablet(context);
//       final isInLandscape = CBOResponsive.isLandScape(context);
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Constants.padding),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               height: isFCMType ? 440 : 280,
//               padding: EdgeInsets.only(
//                   left: Constants.padding, top: Constants.avatarRadius + Constants.padding, right: Constants.padding, bottom: 4),
//               margin: EdgeInsets.only(
//                   top: Constants.avatarRadius,
//                   right: isTablet ? (isInLandscape ? 200 : 100) : 0,
//                   left: isTablet ? (isInLandscape ? 200 : 100) : 0),
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black38, offset: Offset(0, 10), blurRadius: 10),
//                   ]),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     alertTitle,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     height: isFCMType ? 240 : 100,
//                     child: RawScrollbar(
//                       isAlwaysShown: true,
//                       thumbColor: Colors.grey.shade600,
//                       radius: Radius.circular(8),
//                       child: SingleChildScrollView(
//                         child: Text(
//                           isInTest ? MethodUtils.repDefCCode(msg) : msg,
//                           style: TextStyle(fontSize: 16),
//                           textAlign: isFCMType ? TextAlign.start : TextAlign.center,
//                           maxLines: isFCMType ? 40 : null,
//                           overflow: TextOverflow.fade,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   Container(
//                     // padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: negativeCallback != null ? MainAxisAlignment.end : MainAxisAlignment.end,
//                       children: [
//                         if (negativeCallback != null)
//                           Expanded(
//                             child: FlatButton(
//                               color: Colors.grey.shade300,
//                               child: CboText(
//                                 negativeBtnText,
//                                 textColor: Colors.grey.shade900,
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context, false);
//                                 negativeCallback();
//                               },
//                             ),
//                           ),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(
//                           child: FlatButton(
//                               color: primaryColor,
//                               // textColor: primaryColor,
//                               // shape:
//                               // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
//                               child: isRedBtnDialog
//                                   ? CboTextRed(
//                                       positiveBtnText,
//                                       mBold: true,
//                                     )
//                                   : CboTextWhite(
//                                       positiveBtnText,
//                                       mBold: true,
//                                     ),
//                               onPressed: () {
//                                 //for navigation case only, do not pop
//                                 if (!doNotPop) {
//                                   Navigator.pop(context, true);
//                                 }
//                                 if (positiveCallback != null) {
//                                   positiveCallback();
//                                 }
//                               }),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // SizedBox(height: 2,),
//                   if (dcrId > 0)
//                     Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           richText(head: "DCR Date: ", val: CboDateUtils.getFormattedDate(dcrDate)),
//                           richText(head: "", val: "$paID"),
//                         ],
//                       ),
//                     ),
//
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         richText(head: "Date: ", val: CboDateUtils.getFormattedDate(DateTime.now())),
//                         richText(head: "Time: ", val: CboDateUtils.getCurrent24Time(now: DateTime.now())),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         if (dcrId > 0) richText(head: "DCR ID: ", val: "$dcrId"),
//                         richText(head: "Version: ", val: "${AppConfigs().appVersionDisplay}"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Positioned(
//               left: Constants.padding,
//               right: Constants.padding,
//               child: Container(
//                 // height: Constants.avatarRadius,
//                 // width: Constants.avatarRadius,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 3),
//                   shape: BoxShape.circle,
//                   //   boxShadow: [
//                   //   BoxShadow(
//                   //       color: Colors.black38, offset: Offset(0, 10), blurRadius: 10),
//                   // ]
//                 ),
//                 child: CircleAvatar(
//                   backgroundColor: isSuccess ? Colors.green : primaryRed60,
//                   radius: 35,
//                   child: isSuccess
//                       ? Icon(
//                           Icons.check,
//                           color: Colors.white,
//                         )
//                       : Icon(
//                           Icons.clear,
//                           color: Colors.white,
//                           size: 25,
//                         ),
//                 ),
//               ),
//             ),
//             // Positioned(
//             //   top: 50,
//             //   left: 10,
//             //   child: Text("Version : ${AppConfigs().appVersion}", style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),),
//             // ),
//           ],
//         ),
//       );
//
//       // Container(
//       //   padding: EdgeInsets.only(top: 16),
//       //   child: Column(
//       //     mainAxisSize: MainAxisSize.min,
//       //     children: [
//       //       Container(
//       //           padding: const EdgeInsets.symmetric(horizontal: 8),
//       //           child: CboTextBlack(
//       //             "$msg",
//       //             mSize: 16,
//       //             mBold: true,
//       //           )),
//       //       SizedBox(
//       //         height: 24,
//       //       ),
//       //       Container(
//       //         padding: const EdgeInsets.symmetric(horizontal: 8),
//       //         child: Row(
//       //           mainAxisAlignment: negativeCallback != null
//       //               ? MainAxisAlignment.end
//       //               : MainAxisAlignment.end,
//       //           children: [
//       //             if (negativeCallback != null)
//       //               TextButton(
//       //                 child: CboTextBlack(
//       //                   negativeBtnText,
//       //                 ),
//       //                 onPressed: () {
//       //                   Navigator.pop(context, false);
//       //                   negativeCallback();
//       //                 },
//       //               ),
//       //             SizedBox(
//       //               width: 8,
//       //             ),
//       //             TextButton(
//       //               // textColor: primaryColor,
//       //               // shape:
//       //               // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
//       //                 child: isRedBtnDialog
//       //                     ? CboTextRed(
//       //                   positiveBtnText,
//       //                   mBold: true,
//       //                 )
//       //                     : CboTextPrimary(
//       //                   positiveBtnText,
//       //                   mBold: true,
//       //                 ),
//       //                 onPressed: () {
//       //                   Navigator.pop(context, true);
//       //                   if (positiveCallback != null) {
//       //                     positiveCallback();
//       //                   }
//       //                 }),
//       //           ],
//       //         ),
//       //       ),
//       //       Container(
//       //         padding: const EdgeInsets.symmetric(horizontal: 16),
//       //         child: Row(
//       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //           children: [
//       //             CboText(
//       //               "Version: ${AppConfigs().appVersion}",
//       //               mSize: 12,
//       //               mBold: true,
//       //             ),
//       //             Column(
//       //               mainAxisSize: MainAxisSize.min,
//       //               children: [
//       //                 if (dcrDate != null)
//       //                   CboText(
//       //                     "DCR DATE: $dcrDate",
//       //                     textColor: textBlueDark,
//       //                     mSize: 12,
//       //                   ),
//       //                 if (dcrId != null)
//       //                   CboText(
//       //                     "DCR ID: $dcrDate",
//       //                     textColor: textBlueDark,
//       //                     mSize: 12,
//       //                   ),
//       //                 SizedBox.shrink()
//       //               ],
//       //             )
//       //           ],
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       // );
//     },
//   );
// }
