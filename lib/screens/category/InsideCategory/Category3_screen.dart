import 'package:flutter/material.dart';

class Category3Screen extends StatelessWidget {
  const Category3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'CATEGORY 3',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}
