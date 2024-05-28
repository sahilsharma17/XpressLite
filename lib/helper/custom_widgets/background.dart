import 'package:flutter/material.dart';

import '../app_utilities/size_reziser.dart';

class BackGroundScreen extends StatelessWidget {
  String image;
  Widget child;

  BackGroundScreen({required this.image, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            image,
          ),
        ),
      ),
      child: child,
    );
  }
}
