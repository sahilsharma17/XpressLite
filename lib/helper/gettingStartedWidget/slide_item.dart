import 'package:flutter/material.dart';

import 'getting_started_screen.dart';



class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // SizedBox(
        //   height: 40,
        // ),
        // Text(
        //   slideList[index].title,
        //   style: TextStyle(
        //     fontSize: 22,
        //     color: Theme.of(context).primaryColor,
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Text(
        //   slideList[index].description,
        //   textAlign: TextAlign.center,
        // ),
      ],
    );
  }
}
