import 'package:flutter/material.dart';

class Category1Screen extends StatelessWidget {
  const Category1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: Text(
          'CATEGORY 1',
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
