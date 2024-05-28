

import 'package:flutter/material.dart';

import '../../helper/dxWidget/dx_text.dart';

class CircularWidget extends StatelessWidget {
  String date;
  String titleName;
  IconData pdfIcon;
  void Function()? onPressed;
  CircularWidget({ required this.date,required this.titleName, required this.pdfIcon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
              )),
          height: 50,
          width: 90,
          child: Center(
            child: DxTextBlack(
              date,
              mSize: 16.0,
              mBold: true,
              maxLine: 4,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                )),
            height: 50,
            child: Center(
              child: DxTextBlack(

                titleName,
                mSize: 16.0,
                mBold: true,
                maxLine: 4,
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
              )),
          height: 50,
          width: 80,
          child: Center(
            child: InkWell(
              onTap: onPressed,
              child: Icon(
                pdfIcon,color: Colors.red,size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  String date;
  String time;
  String status;
  TimeWidget({ required this.date,required this.time,  required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 90,
            child: Center(
              child: DxTextWhite(
                date,
                mSize: 16.0,
                mBold: true,

              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 0, right: 0),

              height: 20,
              child: Center(
                child: DxTextWhite(

                  time,
                  mSize: 16.0,
                  mBold: true,

                ),
              ),
            ),
          ),

          Container(

            height: 20,
            width: 90,
            child: Center(
              child: DxTextWhite(

                status,
                mSize: 16.0,
                mBold: true,

              ),
            ),
          ),

        ],
      ),
    );
  }
}


class TimeWidgetRow extends StatelessWidget {
  String date;
  String time;
  String status;
  TimeWidgetRow({ required this.date,required this.time,  required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 90,
            child: Center(
              child: DxTextBlack(
                date,
                mSize: 16.0,
                mBold: true,
                maxLine: 4,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 0, right: 0),

              height: 20,
              child: Center(
                child: DxTextBlack(

                  time,
                  mSize: 16.0,
                  mBold: true,
                  maxLine: 4,
                ),
              ),
            ),
          ),

          Container(

            height: 20,
            width: 90,
            child: Center(
              child: DxTextBlack(

                status,
                mSize: 16.0,
                mBold: true,
                maxLine: 4,
              ),
            ),
          ),

        ],
      ),
    );
  }
}






class BirthdayWidget extends StatelessWidget {
  const BirthdayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [

          ],
        )
      ],
    );
  }
}

class TextFieldWithHeading extends StatelessWidget {
  String headingName;
  int? maxLine;
  TextEditingController? controller;
  void Function()? onPressed;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  bool readOnly;


  TextFieldWithHeading(
      {required this.headingName, this.maxLine, this.onPressed, this.controller, this.prefixIcon, this.suffixIcon, this.keyboardType, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DxTextBlack(
          headingName,
          mSize: 18,
          mBold: true,
          maxLine: 10,
        ),
        SizedBox(height: 5,),
        Container(
          child:
          TextField(
            controller: controller,
            readOnly: readOnly,
            textInputAction: TextInputAction.newline,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.black), // Set border color
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            maxLines: maxLine,
            onTap: onPressed,
          ),
        ),
      ],
    );
  }
}
