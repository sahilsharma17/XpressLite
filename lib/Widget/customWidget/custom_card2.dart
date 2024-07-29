import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';

import '../../model/PaginatedNewsModel.dart';
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
                      newsId: widget.eventValue.id!,
                      catId: widget.eventValue.categoryId.toString(),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: screenWidth * 0.6,
          height: screenHeight * 0.65,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.6,
                height: 120,
                child: widget.eventValue.imageFileNames!.isNotEmpty
                    ?
                Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                child: ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: CachedNetworkImage(
                                    imageUrl: widget
                                        .eventValue.imageFileNames![0]
                                        .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20.0),
                                                      topRight: Radius.circular(20.0),
                                                    ),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) {
                                      return Center(
                                          child: Image.asset(
                                              'assets/no_image_found.jpg'));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl: widget.eventValue.imageFileNames![0]
                                  .toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                              ),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              errorWidget: (context, url, error) {
                                return Center(
                                    child: Image.asset(
                                        'assets/no_image_found.jpg'));
                              },
                            ),
                          ),
                        ],
                      )

                    // CachedNetworkImage(
                    //         imageUrl:
                    //             widget.eventValue.imageFileNames![0].toString(),
                    //         imageBuilder: (context, imageProvider) => Container(
                    //           width: 80.0,
                    //           height: 100.0,
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.rectangle,
                    //             borderRadius: BorderRadius.only(
                    //               topLeft: Radius.circular(20.0),
                    //               topRight: Radius.circular(20.0),
                    //             ),
                    //             border:
                    //                 Border.all(color: Colors.black, width: 0.05),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   color: Colors.black,
                    //                   offset: Offset(0.2, 0.2),
                    //                   blurRadius: 0.2,
                    //                   spreadRadius: 0.2)
                    //             ],
                    //             image: DecorationImage(
                    //                 image: imageProvider, fit: BoxFit.cover),
                    //           ),
                    //         ),
                    //         errorWidget: (context, url, error) {
                    //           return Center(
                    //               child: Image.asset('assets/no_image_found.jpg'));
                    //         },
                    //         placeholder: (context, url) => Center(
                    //           child: CircularProgressIndicator(
                    //             color: Colors.orange,
                    //           ),
                    //         ),
                    //       )
                    : Image.asset('assets/no_image_found.jpg'),
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
