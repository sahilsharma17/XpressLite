import 'dart:ui';

import 'package:flutter/material.dart';

class CustomCard3 extends StatefulWidget {
  const CustomCard3({super.key});

  @override
  State<CustomCard3> createState() => _CustomCard3State();
}

class _CustomCard3State extends State<CustomCard3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
      Container(
      color: Colors.red,
      width: (size.width / 2) - 10,
      height: (size.height / 5) - 10,
      child: Column(
        children: [
          Container(
            width: (size.width / 2) - 10,
            height: (size.height / 5),
            child: Stack(
              children: [
                ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Image.asset('assets/img1.jpg', fit: BoxFit.cover,), // Widget that is blurred
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
