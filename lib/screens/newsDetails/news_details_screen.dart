import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_cubit.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_state.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/newsDetailsByIdModel.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsId;

  const NewsDetailsScreen({super.key, required this.newsId});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  int _currentIndex = 0;

  late NewsDetailCubit _cubit;

  NewsDetailsByIdModel? detailsById;

  @override
  void initState() {
    _cubit = BlocProvider.of<NewsDetailCubit>(context);
    _cubit.getIdWiseNewsDetails(widget.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsDetailCubit, NewsDetailScreenState>(
        builder: (BuildContext context, state) {
      if (state is NewsDetailsLoaded) {
        detailsById = state.newsDetailByIdModel;
        return body();
      } else if (state is DetailsScreenInitial) {
        return body();
      } else if (state is DetailsScreenLoading) {
        return Stack(
          children: [body(), const AppLoaderProgress()],
        );
      } else if (state is DetailsScreenError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubit.refresh();
        },
      );
    }, listener: (BuildContext context, state) {
      if (state is DetailsScreenError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is NewsDetailsLoaded) {}
    });
  }

  body() {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'DETAILS',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("Download");
              },
              icon: Icon(
                Icons.download,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        detailsById?.title.toString() ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(20.0),
                  //   child: Image(
                  //     image: AssetImage('assets/img1.jpg'),
                  //   ),
                  // ),
                  Column(
                    children: [
                      CarouselSlider(
                        items: detailsById?.imageFileNames?.map((model) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  debugPrint("Show Details");
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => NewsDetailsScreen(newsId: model.id.toString() ,)));
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.network(
                                      model.toString(),
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                      width: double.infinity,
                                    )),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          //autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        MethodUtils.getFormattedCustomDate(
                            detailsById?.happeningDate.toString() ?? '',
                            'yyyy-mm-ddTHH:MM:SS',
                            'MMMM dd, yyyy'),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                debugPrint("Youtube");
                              },
                              icon: Icon(
                                Icons.record_voice_over,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                debugPrint("Play");
                              },
                              icon: Icon(
                                Icons.speaker,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 0,
                    children: List.generate(5, (index) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      );
                    }),
                  ),
                  Text(
                    "##########",
                    style: TextStyle(color: Colors.orange),
                  ),
                  Text(
                    detailsById?.description.toString() ?? '',
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.thumb_up,
                                color: Colors.orange,
                              )),
                          Text('0')
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.comment,
                                color: Colors.blue,
                              )),
                          Text('0'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              )),
                          Text('0')
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share,
                                color: Colors.blue,
                              )),
                          Text('Share')
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.picture_as_pdf_outlined,
                                color: Colors.red,
                              )),
                          Text("View PDF")
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: screenWidth,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "RELATED HAPPENINGS",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
