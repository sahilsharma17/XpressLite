import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ViewImageScreen extends StatelessWidget {
  final String imgUrl;

  var random = Random();

  ViewImageScreen({required this.imgUrl, Key? key}) : super(key: key);

  Future<void> _saveImage(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late String message;

    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(imgUrl));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/XpressLiteImage${random.nextInt(100)}.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = e.toString();
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ));
    }
  }

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
                _saveImage(context);
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
