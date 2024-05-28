import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/dxWidget/dx_input_fields.dart';
import '../../helper/dxWidget/dx_text.dart';


class TextDailog extends StatefulWidget {
  String? remark;

  TextDailog({ this.remark = ""});

  @override
  State<TextDailog> createState() => _TextDailogState();
}

class _TextDailogState extends State<TextDailog> {

  TextEditingController textController = TextEditingController();
 
 @override
  void initState() {
    textController.text = widget.remark!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  body() => Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DxText(
           "Enter Your Remark",
            mSize: 18,
            mBold: true,
          ),
          const SizedBox(height: 8),

        
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: DxInputText(
              hintText: "",
              valueText: "",
              controller: textController,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context,textController.text);
              },
              child: DxTextWhite(
                "Done",
                mBold: true,
              ))
        ],
      ),
    ),
  );
}

