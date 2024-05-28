import 'package:flutter/material.dart';

import '../helper/app_utilities/app_images.dart';
import '../helper/app_utilities/app_theme.dart';
import '../helper/app_utilities/method_utils.dart';
import '../helper/dxWidget/dx_text.dart';

class LocationAppBar extends StatelessWidget {
  String titleName;
  LocationAppBar({required this.titleName});

  @override
  Widget build(BuildContext context) {
   return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: DxTextWhite(
        titleName,
        mSize: 18,
        mBold: true,
      ),
      actions: [
        InkWell(
          onTap: (){
           MethodUtils.toast( "Location Refreshed");
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(AppImages.locationRefresh,width:30,)),
        )
      ],
    );
  }
}

class SimpleAppBar extends StatelessWidget {
  String titleName;
  Function()? onPressed;
  SimpleAppBar({required this.titleName,this.onPressed});

  @override
  Widget build(BuildContext context) {
   return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onPressed,
      ),
      title: DxTextWhite(
        titleName,
        mSize: 18,
        mBold: true,
      ),
    );
  }
}

class LocationWithSearchBarAppBar extends StatelessWidget {
  String titleName;
  LocationWithSearchBarAppBar({required this.titleName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: DxTextWhite(
        titleName,
        mSize: 18,
        mBold: true,
      ),
      actions: [
        InkWell(
          onTap: (){
           MethodUtils.toast( "Location Refreshed");
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(AppImages.locationRefresh,width:30,)),
        ),
       IconButton(onPressed: (){}, icon: Icon(Icons.search))
      ],
    );
  }
}


class RoundedAppBar extends StatelessWidget {
  String titleName;
  Function()? onPressed;
  RoundedAppBar({required this.titleName,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
      backgroundColor: materialAccentColor,
        automaticallyImplyLeading: false,
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back_ios),
      //   onPressed: onPressed,
      //   color: Colors.white,
      // ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DxText(
            titleName,
            mSize: 26.0,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

