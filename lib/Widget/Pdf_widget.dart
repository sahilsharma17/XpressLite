import 'package:flutter/material.dart';
import 'package:xpresslite/model/allPdfModel.dart';

import '../helper/app_utilities/method_utils.dart';

class PdfWidget extends StatefulWidget {
  AllPdfModel pdfData;
  PdfWidget({super.key, required this.pdfData});

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<PdfWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(children: [
            Opacity(
              opacity: 0.4,
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/message_list_bg.png'),
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 90.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: AssetImage('assets/pdf.png'),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pdfData.title.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          MethodUtils.getFormattedCustomDate(
                              "2024-03-12T15:57:28.187",
                              'yyyy-MM-ddTHH:mm:ss',
                              'dd MMMM, yyyy'),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       widget.eventValue.isFavourite =
                  //           widget.eventValue.isFavourite == false
                  //               ? true
                  //               : false;
                  //     });
                  //   },
                  //   icon: widget.eventValue.isFavourite!
                  //       ? Icon(Icons.favorite, color: Colors.orange)
                  //       : Icon(Icons.favorite_border_outlined,
                  //           color: Colors.orange),
                  //   iconSize: 30,
                  // )
                ],
              ),
            ),

          ]),
        ));
  }
}
