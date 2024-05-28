
import 'package:flutter/material.dart';
import '../app_utilities/app_theme.dart';
import '../dxWidget/dx_text.dart';

class BottomSheetUtils {
  openDescriptionSheets(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: bottom(context),
          );
        });
  }

  bottom(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      // height: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              decoration:  BoxDecoration(
                  color: materialAccentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Center(
                child: DxTextWhite(
                  "Description",
                  mBold: true,
                  mSize: 20,
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: TextField(
                maxLines: 7,

                // controller: Description,
                //inputFormatters: [LengthLimitingTextInputFormatter(50)],
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your Reason",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //openScreenAfterLogin(context, HomeScreen(dashboardListType: 4));
                  },
                  child: DxText(
                    "Cancel",
                    mSize: 16,
                    mBold: true,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    backgroundColor: materialTitlesColor,
                  ),
                ),
              ),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: DxTextWhite(
                    "Ok",
                    mSize: 16,
                    mBold: true,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      backgroundColor: materialAccentColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
