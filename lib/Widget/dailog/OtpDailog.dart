import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../helper/app_utilities/app_theme.dart';
import '../../helper/dxWidget/dx_text.dart';

class OtpDailog extends StatefulWidget {
  bool resendOtpShow = true;
  Function(String)? onPressed;
  Function(String)? onResend;
  String? buttonName;

  OtpDailog({Key? key, this.resendOtpShow = true, this.onPressed, this.onResend, this.buttonName}) : super(key: key);

  @override
  State<OtpDailog> createState() => _OtpDailogState();
}

class _OtpDailogState extends State<OtpDailog> {
  OtpFieldController otpController = OtpFieldController();

  late Timer _timer;
  int _start = 60;
  bool timerShow = false;

  void startTimer() {
    setState(() {
      timerShow = true;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 10;
            timerShow = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            DxText(
              "Enter 6 digit code to continue",
              mSize: 18,
              mBold: true,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  setState(() {
                    otp = pin;
                  });
                  // print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  setState(() {
                    otp = pin;
                  });
                  // print("Completed: " + pin);
                }),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  widget.onPressed!(otp);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black45
                ),
                child: DxText(
                  widget.buttonName ?? "Submit",
                  mBold: true,
                  mSize: 18,
                  textColor:materialPrimaryColor,
                )),
            // const SizedBox(height: 10),
            // Visibility(
            //   visible: widget.resendOtpShow,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       DxTextBlack("Didn't get a code ?"),
            //       timerShow
            //           ? DxText("$_start")
            //           : TextButton(
            //               onPressed: () {
            //                 startTimer();
            //                 setState(() {
            //                   timerShow = true;
            //                 });
            //                 widget.onResend!("resend");
            //               },
            //               child: DxTextBlack(
            //                 "Resend",
            //                 mSize: 18,
            //                 mBold: true,
            //               ),
            //             )
            //     ],
            //   ),
            // ),
            // timerShow
            //     ? const SizedBox(
            //         height: 10,
            //       )
            //     : const SizedBox.shrink(),
            // InkWell(
            //   onTap: ()=> Navigator.pop(context),
            //   child:  DxTextPrimary(
            //   "Change Mobile Number",
            //   mSize: 18,
            //   mBold: true,
            //   maxLines: 2,
            //   textAlign: TextAlign.center,
            // ),),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
