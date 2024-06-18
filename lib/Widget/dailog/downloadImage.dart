import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helper/app_utilities/method_utils.dart';

class DownloadingDialog extends StatefulWidget {
  String? pdfImage;

  DownloadingDialog(this.pdfImage, {Key? key}) : super(key: key);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;
  String? pdfImgg = "";

  @override
  void initState() {
    super.initState();
    // pdfImgg = widget.pdfImage;
    MethodUtils.toast("Downloading Started");
    startDownloading();
  }

  void startDownloading() async {
    await Permission.storage.request();
    // pdfImgg = widget.pdfImage;
    const String pdfImgg =
        "https://ep2.businesstowork.com/upload/JOB_01102022_1_15283.jpg";
    // const String url =
    //    "https://ep5.exhibitpower.com/upload/61256_ASDS_Annual_Meeting_2022_Shepard_Exhibitor_Manual.pdf";
    //  const String url1 =
    //      'https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';

    const String fileName = "ExhibitPower.jpg";
    // ExhibitP
    String path = await _getFilePath(fileName);
    print("download path is $path");

    try {
      Response response = await dio.get(
        pdfImgg.toString(),
        onReceiveProgress: (recivedBytes, totalBytes) {
          setState(() {
            progress = recivedBytes / totalBytes;
          });

          print(progress);
        },
        // deleteOnError: true,
      );

      File file = File(path);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeString(response.data);
      await raf.close();

      Navigator.pop(context);
    } catch (e) {}

    if (progress == 1.0) {
      Navigator.pop(context);
      MethodUtils.toast("Downloading Completed");
    }
  }

  Future<String> _getFilePath(String filename) async {
    // final dir = await getApplicationDocumentsDirectory();
    final dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    return "${dir}/$filename";
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
