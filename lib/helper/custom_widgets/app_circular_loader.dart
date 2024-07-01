import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../app_utilities/app_images.dart';
import '../app_utilities/size_reziser.dart';

class AppLoaderProgress extends StatelessWidget {
  const AppLoaderProgress();

  @override
  Widget build(BuildContext context) {
    bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: Colors.grey.shade200,
      child: Center(
        child:  Container(
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child:  Padding(
                  padding: const EdgeInsets.all(4.0),
                  // child: Image.asset(AppImages.loader)
                  child: CircularProgressIndicator()
                )

        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
