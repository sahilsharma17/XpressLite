import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';
import 'package:xpresslite/screens/fav/cubit/favs_screen_cubit.dart';
import 'package:xpresslite/screens/home/cubit/home_cubit.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_cubit.dart';
import '../../model/PaginatedNewsModel.dart';
import '../../screens/newsDetails/news_details_screen.dart';

class CustomCard extends StatefulWidget {
  final HomeCubit? homeCubit;
  final NewsDetailScreenCubit? newsDetailScreenCubit;
  final FavsScreenCubit? favCubit;
  final PaginatedNewsModel eventValue;

  CustomCard({
    Key? key,
    required this.eventValue,
    this.homeCubit,
    this.newsDetailScreenCubit,
    this.favCubit,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
              newsId: widget.eventValue.id.toString(),
              catId: widget.eventValue.categoryId.toString(),
            ),
          ),
        );

        // Check if result is not null and is a string
        if (result != null && result is String) {
          // Update the state or reload data here using the returned newsId
          if (mounted) {
            setState(() {
              widget.eventValue.id = int.parse(result);
              print("Here ${widget.eventValue.id}");
            });
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Container(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 100,
                    child:
                        widget.eventValue.imageFileNames!.isNotEmpty ?
                    CachedNetworkImage(
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
                      errorWidget: (context, url, error) {
                        return Center(
                            child: Image.asset(
                                'assets/no_image_found.jpg'));
                      },
                    ) : Image.asset('assets/no_image_found.jpg'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.eventValue.title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
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
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.eventValue.isFavourite =
                                  !(widget.eventValue.isFavourite ?? false);
                                });

                                if (widget.homeCubit != null) {
                                  widget.homeCubit?.updateFavNews(
                                      widget.eventValue.id!,
                                      widget.eventValue.isFavourite!);
                                } else if (widget.newsDetailScreenCubit !=
                                    null) {
                                  widget.newsDetailScreenCubit?.updateFavNews(
                                      widget.eventValue.id!,
                                      widget.eventValue.isFavourite!);
                                } else if (widget.favCubit != null) {
                                  widget.favCubit?.updateFavNews(
                                      widget.eventValue.id!,
                                      widget.eventValue.isFavourite!);
                                  setState(() {

                                  });

                                }
                              },
                              icon: Icon(
                                widget.eventValue.isFavourite!
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Colors.orange,
                              ),
                              iconSize: 24,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/divider.png')
            ],
          ),
        ),
      ),
    );
  }
}
