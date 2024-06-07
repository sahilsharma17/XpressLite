import 'package:flutter/material.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';
import 'package:xpresslite/model/categorised_news_detail_model.dart';

import '../../screens/newsDetails/news_details_screen.dart';

class CustomCard extends StatefulWidget {
  CategorisedNewsDetailsModel eventValue;

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.2, 0.2),
                          blurRadius: 0.2,
                          spreadRadius: 0.2)
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.eventValue.imageFileNames.toString()),
                      fit: BoxFit.cover,
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
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        MethodUtils.getFormattedCustomDate(
                            "2024-05-21T10:48:00",
                            'yyyy-MM-ddTHH:mm:ss',
                            'dd MMMM, yyyy'),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "2 weeks ago",
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
                //       widget.eventValue.isLiked = widget.eventValue.isLiked == false? true : false;
                //     });
                //   },
                //   icon: widget.eventValue.isLiked!
                //       ? Icon(Icons.favorite, color: Colors.orange)
                //       : Icon(Icons.favorite_border_outlined, color: Colors.orange),
                //   iconSize: 30,
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
