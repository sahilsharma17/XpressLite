import 'package:flutter/material.dart';

import '../app_utilities/app_theme.dart';
import '../app_utilities/method_utils.dart';
import 'dx_text.dart';


class ButtonElevated extends StatelessWidget {
  Function()? onPressed;
  String name;
  Color? color = Colors.white;
  bool buttonPrimaryColor ;

  ButtonElevated({
    required this.onPressed,
    required this.name,
    this.color = Colors.white,
    this.buttonPrimaryColor=false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: MethodUtils.raisedButtonStyle(buttonPrimaryColor ? materialPrimaryColor : materialAccentColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: DxText(
              name,
              mBold: true,
              mSize: 18,
              maxLines: 2,
              textAlign: TextAlign.center,
              textColor: color!,
            ),
          )),
    );
  }
}
