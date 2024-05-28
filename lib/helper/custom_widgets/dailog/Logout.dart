import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../app_utilities/app_theme.dart';
import '../../app_utilities/date_utils.dart';
import '../../app_utilities/device_info.dart';
import '../../app_utilities/method_utils.dart';
import '../../dxWidget/dx_text.dart';
import '../../localStorage/preference_handler.dart';

class LogoutDailog extends StatefulWidget {
  _LogoutDailogState createState() => _LogoutDailogState();
}

class _LogoutDailogState extends State<LogoutDailog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 150,
        width: 250,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DxTextBlack(
              "Logout Confirmation?",
              mBold: true,
            ),
            SizedBox(
              height: 10,
            ),
            DxTextBlack(
              "Are you sure want to Logout?",
              mBold: true,
              mSize: 14,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      PreferenceHandler.logout(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.6, color: materialPrimaryColor)),
                      child: DxText(
                        "Yes",
                        mBold: true,
                      ),
                      height: 35,
                      width: 70,
                    ),
                  ),
                  // child: Container(
                  // child: OutlineButton(
                  //   padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                  //   borderSide: BorderSide(width: 0.6,color: materialPrimaryColor),
                  //   onPressed: (){
                  //     PreferenceHandler.logout(context);
                  //
                  //   },
                  //   textColor: Colors.black,
                  //   child: DxText("Yes",mBold: true,),
                  //   highlightedBorderColor: materialPrimaryColor,
                  // ),
                  //   height: 35,
                  //   width: 70,
                  // ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.6, color: materialPrimaryColor)),
                      child: DxText(
                        "No",
                        mBold: true,
                      ),
                      height: 35,
                      width: 70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//NEW Dialog
Future commonDialog(String msg,
    {Function()? positiveCallback,
    Function()? negativeCallback,
    bool isSuccess = true,
    String alertTitle = "Alert!!",
    String positiveBtnText = "OK",
    String negativeBtnText = "Cancel",
    String? dcrDate,
    String? dcrId,
    //for navigation case only.
    bool doNotPop = false,
    bool isFCMType = false,
    bool isRedBtnDialog = false}) async {
  final dcrDate = await PreferenceHandler.getEmployeeCode();
  final paID = await PreferenceHandler.getUserId();
  final dcrId = await PreferenceHandler.getUserId();
  final androidVersion = "";

  RichText richText({String? head, String? val}) => RichText(
          text: TextSpan(
              text: head,
              style: TextStyle(
                  fontSize: 10),
              children: <TextSpan>[
            TextSpan(
                text: val,
                style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ))
          ]));
  // bool isInTest = BlocProvider.of<SplashCubit>(context).getTestConfigs.testingStatus;
  return showDialog<bool>(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      print("Working");

      final isTablet = DeviceInfo.useMobileLayout(navigatorKey.currentContext!);
      // final isInLandscape = CBOResponsive.isLandScape(context);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 8, top: 35 + 8, right: 8, bottom: 4),
              margin: EdgeInsets.only(
                  top: 35,
                  right: isTablet ? (10) : 0,
                  left: isTablet ? (10) : 0),
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
                  SizedBox(
                    height: 10,
                  ),
                  DxTextBlack(
                    alertTitle,
                    mSize: 25,
                    mBold: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(8),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      thumbColor: Colors.grey.shade600,
                      radius: Radius.circular(8),
                      child: SingleChildScrollView(
                          child: DxText(
                        msg,
                        mBold: true,
                        mSize: 20,
                        maxLines: 10,
                            textAlign: TextAlign.center,

                      )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: negativeCallback != null
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.end,
                      children: [
                        if (negativeCallback != null)
                          Expanded(
                            child: ElevatedButton(
                              style: MethodUtils.raisedButtonStyle(Colors.red),
                              // color: Colors.grey.shade300,
                              child: DxTextWhite(negativeBtnText),
                              onPressed: () {
                                negativeCallback();
                              },
                            ),
                          ),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style:
                                  MethodUtils.raisedButtonStyle(Colors.green),
                              // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
                              child: isRedBtnDialog
                                  ? DxTextRed(
                                      positiveBtnText,
                                      mBold: true,
                                    )
                                  : DxTextWhite(
                                      positiveBtnText,
                                      mBold: true,
                                    ),
                              onPressed: () {
                                //for navigation case only, do not pop
                                if (!doNotPop) {
                                  Navigator.pop(
                                      navigatorKey.currentContext!, true);
                                }
                                if (positiveCallback != null) {
                                  positiveCallback();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 2,),

                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       richText(head: "Date: ", val: AppDateUtils.getFormattedDmyString(DateTime.now())),
                  //       richText(head: "Time: ", val: AppDateUtils.getFormattedDmyString(DateTime.now())),
                  //     ],
                  //   ),
                  // ),
                  //
                  //
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       richText(head: "OS Version: ", val: "${androidVersion}"),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),

            Positioned(
              left: 8,
              right: 8,
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
                child: CircleAvatar(
                  backgroundColor: isSuccess ? Colors.green : primaryRed60,
                  radius: 35,
                  child: isSuccess
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
            // Positioned(
            //   top: 50,
            //   left: 10,
            //   child: Text("Version : ${AppConfigs().appVersion}", style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),),
            // ),
          ],
        ),
      );

      // Container(
      //   padding: EdgeInsets.only(top: 16),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Container(
      //           padding: const EdgeInsets.symmetric(horizontal: 8),
      //           child: CboTextBlack(
      //             "$msg",
      //             mSize: 16,
      //             mBold: true,
      //           )),
      //       SizedBox(
      //         height: 24,
      //       ),
      //       Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 8),
      //         child: Row(
      //           mainAxisAlignment: negativeCallback != null
      //               ? MainAxisAlignment.end
      //               : MainAxisAlignment.end,
      //           children: [
      //             if (negativeCallback != null)
      //               TextButton(
      //                 child: CboTextBlack(
      //                   negativeBtnText,
      //                 ),
      //                 onPressed: () {
      //                   Navigator.pop(context, false);
      //                   negativeCallback();
      //                 },
      //               ),
      //             SizedBox(
      //               width: 8,
      //             ),
      //             TextButton(
      //               // textColor: primaryColor,
      //               // shape:
      //               // RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Colors.red.shade100)),
      //                 child: isRedBtnDialog
      //                     ? CboTextRed(
      //                   positiveBtnText,
      //                   mBold: true,
      //                 )
      //                     : CboTextPrimary(
      //                   positiveBtnText,
      //                   mBold: true,
      //                 ),
      //                 onPressed: () {
      //                   Navigator.pop(context, true);
      //                   if (positiveCallback != null) {
      //                     positiveCallback();
      //                   }
      //                 }),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             CboText(
      //               "Version: ${AppConfigs().appVersion}",
      //               mSize: 12,
      //               mBold: true,
      //             ),
      //             Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 if (dcrDate != null)
      //                   CboText(
      //                     "DCR DATE: $dcrDate",
      //                     textColor: textBlueDark,
      //                     mSize: 12,
      //                   ),
      //                 if (dcrId != null)
      //                   CboText(
      //                     "DCR ID: $dcrDate",
      //                     textColor: textBlueDark,
      //                     mSize: 12,
      //                   ),
      //                 SizedBox.shrink()
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // );
    },
  );
}
