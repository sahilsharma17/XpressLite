import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';

import '../../model/PaginatedNewsModel .dart';
import '../../screens/newsDetails/news_details_screen.dart';

class CustomCard2 extends StatefulWidget {
  PaginatedNewsModel eventValue;

  CustomCard2({Key? key, required this.eventValue}) : super(key: key);

  @override
  State<CustomCard2> createState() => _CustomCard2State();
}

class _CustomCard2State extends State<CustomCard2> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailsScreen(
                      newsId: widget.eventValue.id.toString(),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: screenWidth * 0.6,
          height: screenWidth * 0.65,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black, width: 0.2),
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.2, 0.2),
                  blurRadius: 0.2,
                  spreadRadius: 0.2)
            ],
          ),
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.6,
                height: 120,
                child: CachedNetworkImage(
                  imageUrl: widget.eventValue.imageFileNames![0].toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      border: Border.all(color: Colors.black, width: 0.05),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.2, 0.2),
                            blurRadius: 0.2,
                            spreadRadius: 0.2)
                      ],
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MethodUtils.getFormattedCustomDate(
                          widget.eventValue.happeningDate.toString(),
                          'yyyy-MM-ddTHH:mm:ss',
                          'dd MMMM, yyyy'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.eventValue.title.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
