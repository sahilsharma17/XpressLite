import 'package:flutter/material.dart';

import '../../app_utilities/app_images.dart';
import '../../app_utilities/size_reziser.dart';
import '../../dxWidget/dx_text.dart';

class AccessDeniedScreen extends StatefulWidget {
  Function()? onPressed;
  String? msg;

  AccessDeniedScreen({Key? key, this.onPressed,this.msg}) : super(key: key);

  @override
  State<AccessDeniedScreen> createState() => _AccessDeniedScreenState();
}

class _AccessDeniedScreenState extends State<AccessDeniedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.accessDenied,
              height: 350,
            ),
            const SizedBox(height: 15),
            DxTextBlack(widget.msg??"",mBold: true,maxLine: 15,textAlign: TextAlign.center,),
            const SizedBox(height: 15),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                child: DxTextBlack(
                  "Retry",
                  mBold: true,
                  mSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
