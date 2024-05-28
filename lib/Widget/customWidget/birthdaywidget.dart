
import 'package:flutter/material.dart';

import '../../helper/app_utilities/app_theme.dart';
import '../../helper/dxWidget/dx_text.dart';

class BirthdayWidget extends StatelessWidget {

  String name;
  String profile;
  AssetImage profileImage;
  // TextEditingController textController;


   BirthdayWidget({required this.name, required this.profile, required this.profileImage,});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: profileImage
            ),
            title: DxTextBlack(
              name,
              mSize: 18,
            ),
            subtitle: DxText(profile, textColor: Colors.blue,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              // controller: textController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Send your best wishes...',
                hintStyle: TextStyle(fontSize: 16, color: Colors.black87),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[400],
                contentPadding: EdgeInsets.all(16),
                suffixIcon: Icon(Icons.send, color: materialPrimaryColor),
              ),
            ),

          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
