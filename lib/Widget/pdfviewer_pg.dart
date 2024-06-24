import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:math';

import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  PdfViewerScreen({required this.pdfUrl});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  var random = Random();


  @override
  Widget build(BuildContext context) {

    Future<void> _savePdf(BuildContext context) async {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      late String message;

      try {
        // Download image
        final http.Response response = await http.get(Uri.parse(widget.pdfUrl));

        // Get temporary directory
        final dir = await getTemporaryDirectory();

        // Create an image name
        var filename = '${dir.path}/XpressLitePdf${random.nextInt(100)}.pdf';

        // Save to filesystem
        final file = File(filename);
        await file.writeAsBytes(response.bodyBytes);

        // Ask the user to save it
        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);

        if (finalPath != null) {
          message = 'Pdf Saved to device';
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

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: Text(
          'VIEW PDF',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("Download");
                _savePdf(context);

              },
              icon: Icon(
                Icons.download,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl ?? "",
        key: _pdfViewerKey,
        scrollDirection: PdfScrollDirection.horizontal,
      ),
    );
  }
}

