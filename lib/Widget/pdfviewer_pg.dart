import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../helper/app_utilities/app_theme.dart';
import '../helper/dxWidget/dx_text.dart';
import 'appBar.dart';

class PdfViewerScreen extends StatefulWidget {
  String? pdfUrl;
   PdfViewerScreen({this.pdfUrl});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        elevation: 0,
        backgroundColor: materialAccentColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DxText(
              "PDF Viewer",
              mSize: 26.0,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl ?? "",
        key: _pdfViewerKey,
      ),
    );
  }
}





class PdfViewerAssetScreen extends StatefulWidget {

  const PdfViewerAssetScreen({super.key});

  @override
  State<PdfViewerAssetScreen> createState() => _PdfViewerAssetScreenState();
}

class _PdfViewerAssetScreenState extends State<PdfViewerAssetScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        elevation: 0,
        backgroundColor: materialAccentColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DxText(
              "PDF Viewer",
              mSize: 26.0,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      body: SfPdfViewer.asset(
       'assets/images/PaySlip_1_2024.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
