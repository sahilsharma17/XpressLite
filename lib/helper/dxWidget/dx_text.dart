import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:student_advisor/helper/app_utilities/dx_app_decoration.dart';
// import 'package:student_advisor/helper/app_utilities/size_reziser.dart';

import '../app_utilities/dx_app_decoration.dart';
import '../app_utilities/size_reziser.dart';


class DxTextWhite extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;

  DxTextWhite(this.mTitle, {this.mBold = false, this.mSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      style: AppStyles.getTextStyleWhite(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextBlack extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;
  FontWeight fontWeight;
  TextOverflow overflow;
  int? maxLine;

  DxTextBlack(this.mTitle, {this.textAlign,this.maxLine =1,this.overflow = TextOverflow.ellipsis, this.mBold = false, this.mSize = 16, this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      overflow: overflow,
      maxLines: maxLine,
      style: this.mBold
          ? AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context), fontWeight: this.fontWeight)
          : AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context)),
      textAlign: textAlign,
    );
  }
}

class DxText extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  Color textColor;
  TextAlign? textAlign;
  int maxLines;
  TextOverflow overflow;
  bool lineThrough ;


  DxText(this.mTitle,
      {this.mBold = false,
      this.maxLines = 1,
      this.textAlign,
      this.mSize = 16,
        this.lineThrough = false,
      this.overflow = TextOverflow.ellipsis,
      this.textColor = Colors.black, Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return lineThrough ?Text(
      this.mTitle,
      style: AppStyles.getTextStrikeThrough(this.mBold, getSize(this.mSize, context), textColor: textColor, ),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    ):Text(
      this.mTitle,
      style: AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context), color: textColor),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class DxTextRed extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;

  DxTextRed(this.mTitle, {this.mBold = false, this.mSize = 16,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      textAlign: textAlign,
      style: AppStyles.getTextStyleRed(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextGreen extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;
  DxTextGreen(this.mTitle, {this.mBold = false, this.mSize = 16,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      textAlign: textAlign,
      style: AppStyles.getTextStyleGreen(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextPrimary extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign textAlign;
  int maxLines;

  DxTextPrimary(this.mTitle, {this.mBold = false, this.mSize = 16, this.textAlign = TextAlign.left,this.maxLines = 1,});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      style: AppStyles.getTextStylePrimary(this.mBold, getSize(this.mSize, context)),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class DxReachPrimary extends StatelessWidget {
  String mTitle;
  String mSubTitle;
  double mTitleSize;
  double mSubTitleSize;
  TextAlign textAlign;
  bool boldTitle;
  bool boldSubTitle;

  DxReachPrimary(this.mTitle,
      {this.mTitleSize = 17,
      this.mSubTitleSize = 14,
      this.textAlign = TextAlign.left,
      this.mSubTitle = "",
      this.boldTitle  = false,
      this.boldSubTitle = false}) {
    this.boldTitle = true;
    this.boldSubTitle = false;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: new TextSpan(
        style: AppStyles.getTextStylePrimary(false, getSize(this.mTitleSize, context)),
        children: <TextSpan>[
          new TextSpan(
              text: this.mTitle,
              style: new TextStyle(
                fontSize: this.mTitleSize,
                fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
              )),
          new TextSpan(
              text: this.mSubTitle,
              style: new TextStyle(fontSize: this.mSubTitleSize, fontWeight: boldSubTitle ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}


class Heading1 extends StatelessWidget {
  String title, value;
  Color color;
  int? maxLines;
  TextOverflow? overflow;
  Heading1({Key? key,required this.title,required this.value,this.color = Colors.black,
    this.maxLines,
    this.overflow,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          child: DxTextBlack(
            title,
            mSize: 18,
            maxLine: 3,
            mBold: true,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: DxText(
                value,
                mSize: 18,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textColor: color,
              )),
        ),
      ],
    );
  }
}

class Heading3 extends StatelessWidget {
  String title, value;
  Color color;
  int? maxLines;
  TextOverflow? overflow;
  Heading3({Key? key,required this.title,required this.value,this.color = Colors.white,
    this.maxLines,
    this.overflow,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DxText(
          title,
          mSize: 16,
          mBold: true,
          textColor: color,
        ),
        DxText(
          value,
          mSize: 16,
          mBold: true,
          textColor: color,
        ),

      ],
    );
  }
}



class DescriptionHeading extends StatelessWidget {
  String title, value;
  Color color;
  int maxLines;
  TextOverflow overflow;
  DescriptionHeading({Key? key,required this.title,required this.value,this.color = Colors.black,
    required this.maxLines,
    required this.overflow,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 130,
          child: DxTextBlack(
            title,
            mSize: 18,
            maxLine: 3,
            mBold: true,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: DxText(
                value,
                mSize: 18,
                maxLines:maxLines,
                overflow: overflow,
                textColor: color,
              )),
        ),
      ],
    );
  }
}


class Heading2 extends StatelessWidget {
  String title;
  Color color;
  IconData icons;
  Heading2({Key? key,required this.title,this.color = Colors.black, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          child: DxTextBlack(
            title,
            mSize: 18,
            maxLine: 3,
            mBold: true,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Icon(icons,size: 30,color: Colors.blue,

              )),
        ),
      ],
    );
  }
}
