import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/Widget/customWidget/commentBarWidget.dart';
import 'package:xpresslite/helper/bottomsheet/bottomsheet.dart';
import 'package:xpresslite/model/newsFeaturesModel.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_cubit.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_state.dart';

import '../../Widget/customWidget/custom_card.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/PaginatedNewsModel .dart';
import '../../model/newsCommentsModel.dart';
import '../../model/newsDetailsByIdModel.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsId;
  final String catId;

  const NewsDetailsScreen(
      {super.key, required this.newsId, required this.catId});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  TextEditingController commentController = TextEditingController();
  int _currentIndex = 0;

  bool showComment = false;

  late NewsDetailScreenCubit _cubit;

  NewsDetailsByIdModel? detailsById;

  NewsFeaturesModel? newsFeaturesModel;

  List<NewsCommentsModel>? newsComments;

  List<PaginatedNewsModel>? relatedHappeningModel = [];

  List? pc;
  List? delCom;
  List? newCom;

  @override
  void initState() {
    _cubit = BlocProvider.of<NewsDetailScreenCubit>(context);
    _cubit.getIdWiseNewsDetails(widget.newsId, widget.catId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsDetailScreenCubit, NewsDetailScreenState>(
        builder: (BuildContext context, state) {
      if (state is NewsCommentsLoaded) {
        detailsById = state.newsDetailByIdModel;
        newsComments = state.newsCommentsModel ?? [];
        newsFeaturesModel = state.newsFeaturesModel;
        relatedHappeningModel = state.relatedHappeningModel ?? [];
        pc = state.pComment ?? [];
        delCom = state.delComment ?? [];
        newCom = state.updateComment ?? [];

        return body();
      } else if (state is DetailsScreenInitial) {
        return AppLoaderProgress();
      } else if (state is DetailsScreenLoading) {
        return Stack(
          children: [const AppLoaderProgress()],
        );
      } else if (state is DetailsScreenError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubit.getIdWiseNewsDetails(widget.newsId, widget.catId);
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
                                    child: CachedNetworkImage(
                                      imageUrl: model.toString(),
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                      width: double.infinity,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.orange,
                                        ),
                                      ),
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
                            'yyyy-MM-ddTHH:mm:ss',
                            'dd MMMM, yyyy'),
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
                      int n = detailsById?.calculatedRating != null
                          ? int.parse(
                              detailsById!.calculatedRating!.split('.').first)
                          : 0;
                      final isGolden = index < n;
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          Icons.star,
                          color: isGolden ? Colors.amber : Colors.grey,
                        ),
                        onPressed: () {},
                      );
                    }),
                  ),
                  Text(
                    detailsById!.newsHashtagsOnNews
                            ?.map((e) => e.hashtag)
                            .join(' ') ??
                        '',
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
                          Text(newsFeaturesModel?.totalLikes.toString() ?? "0")
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
                          Text(newsFeaturesModel?.totalComments.toString() ??
                              "0")
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
                          Text(newsFeaturesModel?.totalViews.toString() ?? "0")
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (newsComments!.isNotEmpty)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showComment = !showComment;
                            });
                          },
                          child: Text(
                            textAlign: TextAlign.right,
                            'Comments',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                          visible: showComment,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: newsComments?.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: NetworkImage(
                                                newsComments?[i]
                                                        .profileImage
                                                        ?.toString() ??
                                                    ''),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: screenWidth * 0.7,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        newsComments?[i]
                                                                .name
                                                                ?.toString() ??
                                                            '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        newsComments?[i]
                                                                .comment
                                                                ?.toString() ??
                                                            '',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'time ago',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {},
                                                          child: Text('Like',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black87))),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {},
                                                          child: Text('Reply',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black87))),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return MyBottomSheet(
                                                                  oldComment:
                                                                      newsComments![
                                                                              i]
                                                                          .comment
                                                                          .toString(),
                                                                  cubit: _cubit,
                                                                  commentId:
                                                                      newsComments?[i]
                                                                              .commentId ??
                                                                          0,
                                                                  categoryId:
                                                                      widget
                                                                          .catId,
                                                                  newsId: widget
                                                                      .newsId,
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons.edit_outlined,
                                                            size: 20,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Dialog(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          150,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                'XpressLite',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Text(
                                                                                textAlign: TextAlign.center,
                                                                                'Are you Sure? You want to delete this comment.',
                                                                                style: TextStyle(fontWeight: FontWeight.normal),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                        onTap: () {
                                                                                          print('No');
                                                                                        },
                                                                                        child: Container(height: 30, width: 100, child: Text(textAlign: TextAlign.center, 'No', style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold)))),
                                                                                    GestureDetector(
                                                                                        onTap: () {
                                                                                          print('Yes');
                                                                                          Navigator.pop(context, true);
                                                                                          _cubit.deleteComment(widget.newsId, widget.catId, newsComments?[i].commentId ?? 0, '');
                                                                                        },
                                                                                        child: Container(height: 30, width: 100, child: Text(textAlign: TextAlign.center, 'Yes', style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold)))),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .delete_forever_outlined,
                                                            size: 20,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      if (newsComments![i]
                                              .replies!
                                              .isNotEmpty ||
                                          newsComments![i].replies != null)
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              newsComments?[i].replies?.length,
                                          itemBuilder:
                                              (BuildContext context, int j) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 40, top: 10),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 18.0,
                                                    backgroundImage: NetworkImage(
                                                        newsComments![i]
                                                                .replies?[j]
                                                                .profileImage
                                                                ?.toString() ??
                                                            ''),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: screenWidth * 0.65,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            newsComments![i]
                                                                    .replies?[j]
                                                                    .name
                                                                    ?.toString() ??
                                                                '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            newsComments![i]
                                                                    .replies?[j]
                                                                    .commentsReply
                                                                    ?.toString() ??
                                                                '',
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child: Text(
                                                                          'Like',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black87))),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child: Text(
                                                                          'Reply',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black87))),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        // showModalBottomSheet(
                                                                        //   context:
                                                                        //       context,
                                                                        //   builder:
                                                                        //       (BuildContext context) {
                                                                        //     return MyBottomSheet();
                                                                        //   },
                                                                        // );
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .edit_outlined,
                                                                        size:
                                                                            20,
                                                                      )),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return Dialog(
                                                                                child: Container(
                                                                                  width: 100,
                                                                                  height: 150,
                                                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Text(
                                                                                            'XpressLite',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            'Are you Sure? You want to delete this comment.',
                                                                                            style: TextStyle(fontWeight: FontWeight.normal),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                              children: [
                                                                                                GestureDetector(
                                                                                                    onTap: () {
                                                                                                      print('No');
                                                                                                    },
                                                                                                    child: Container(height: 30, width: 100, child: Text(textAlign: TextAlign.center, 'No', style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold)))),
                                                                                                GestureDetector(
                                                                                                    onTap: () {
                                                                                                      print('Yes');
                                                                                                      Navigator.pop(context, true);
                                                                                                      _cubit.deleteComment(widget.newsId, widget.catId, newsComments?[i].commentId ?? 0, newsComments?[i].replies![j].commentReplyId.toString() ?? '');
                                                                                                    },
                                                                                                    child: Container(height: 30, width: 100, child: Text(textAlign: TextAlign.center, 'Yes', style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold)))),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            });
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .delete_forever_outlined,
                                                                        size:
                                                                            20,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                    ]));
                              },
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
            Container(
              width: screenWidth,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Text(
                      "RELATED HAPPENINGS",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: relatedHappeningModel?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey.withOpacity(0.2),
                          child: Column(
                            children: [
                              CustomCard(
                                  eventValue: relatedHappeningModel![index]),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CommentBottomBar(
            controller: commentController,
            onSend: () {
              _cubit.postComment(
                  widget.newsId, commentController.text, widget.catId);
              commentController.text = '';
            }),
      ),
    );
  }
}
