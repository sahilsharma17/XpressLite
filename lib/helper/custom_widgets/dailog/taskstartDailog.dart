import 'package:flutter/material.dart';
import '../../app_utilities/app_theme.dart';
import '../../dxWidget/dx_text.dart';
import '../../localStorage/preference_handler.dart';

String clockStart = "";

class StartTaskDialog extends StatefulWidget {
  const StartTaskDialog({super.key});

  @override
  State<StartTaskDialog> createState() => _StartTaskDialogState();
}

class _StartTaskDialogState extends State<StartTaskDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 150,
        width: 250,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: DxTextBlack(
                "Start Task",
                mBold: true,
                mSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: DxTextBlack(
                "Are you sure?",
                mBold: false,
                mSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: DxTextBlack(
                      "No",
                      mSize: 16,
                      mBold: true,
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Colors.white),
                  ),
                ),
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
             PreferenceHandler.setClockStart("start");
             // Navigator.pop(context);




                    },
                    child: DxTextWhite(
                      "Yes",
                      mSize: 16,
                      mBold: true,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      backgroundColor: materialAccentColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
