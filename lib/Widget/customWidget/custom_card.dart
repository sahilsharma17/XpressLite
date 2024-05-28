import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpresslite/model/categorised_news_detail_model.dart';

class CustomCard extends StatefulWidget {
  CategorisedNewsDetailsModel eventValue;

  CustomCard({Key? key, required this.eventValue}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      surfaceTintColor: Colors.white70,
      shape: ContinuousRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image:
                      NetworkImage(widget.eventValue.imageFileNames.toString()),
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
                  // Text(
                  //   getFormattedCoustomDate(widget.eventValue.eventShowDate.toString(), 'yyyy-mm-ddTHH:MM:SS', 'MMMM dd, yyyy'),
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: 14,
                  //   ),
                  // ),
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
      ),
    );
  }

  static String getFormattedCoustomDate(
      String date, String inputDateFormat, String outputDateFormat) {
    /// Convert into local date format.
    var localDate = date;

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat(outputDateFormat);
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
}
