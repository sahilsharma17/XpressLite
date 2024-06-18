import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  final String imgUrl;

  const ViewImageScreen({required this.imgUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: Text(
          'VIEW IMAGE',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("Download");
              },
              icon: Icon(
                Icons.download,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Image.network(
            imgUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
