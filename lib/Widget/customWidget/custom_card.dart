import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';

import '../../model/PaginatedNewsModel .dart';
import '../../screens/newsDetails/news_details_screen.dart';

class CustomCard extends StatefulWidget {
  PaginatedNewsModel eventValue;

  CustomCard({Key? key, required this.eventValue}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: widget.eventValue.imageFileNames![0].toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0),
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
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.eventValue.title.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          MethodUtils.getFormattedCustomDate(
                              widget.eventValue.happeningDate.toString(),
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.eventValue.isFavourite =
                            widget.eventValue.isFavourite == false
                                ? true
                                : false;
                      });
                    },
                    icon: widget.eventValue.isFavourite!
                        ? Icon(Icons.favorite, color: Colors.orange)
                        : Icon(Icons.favorite_border_outlined,
                            color: Colors.orange),
                    iconSize: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
