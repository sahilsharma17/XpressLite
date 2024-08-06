import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:xpresslite/Widget/customWidget/commentBarWidget.dart';
import 'package:xpresslite/Widget/pdfviewer_pg.dart';
import 'package:xpresslite/helper/app_utilities/size_reziser.dart';
import 'package:xpresslite/helper/bottomsheet/bottomsheet.dart';
import 'package:xpresslite/helper/routeAndBlocManager/navigator.dart';
import 'package:xpresslite/model/newsFeaturesModel.dart';
import 'package:xpresslite/screens/Dashboard/BottomNav/bottomNav.dart';
import 'package:xpresslite/screens/appNavBar.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_cubit.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_state.dart';
import 'package:xpresslite/screens/newsDetails/youtube_player_screen.dart';
import 'package:xpresslite/screens/reply/reply_screen.dart';

import '../../Widget/customWidget/custom_card.dart';
import '../../Widget/customWidget/news_features_widget.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/PaginatedNewsModel.dart';
import '../../model/newsCommentsModel.dart';
import '../../model/newsDetailsByIdModel.dart';
import '../view_image/view_image_screen.dart';

class NewsDetailsScreen extends StatefulWidget {
  int newsId;
  String catId;

  NewsDetailsScreen({super.key, required this.newsId, required this.catId});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  TextEditingController commentController = TextEditingController();
  int _currentIndex = 0;

  FlutterTts _tts = FlutterTts();

  bool reading = false;

  bool showComment = false;

  late NewsDetailScreenCubit _cubit;
  NewsDetailsByIdModel? detailsById;
  NewsFeaturesModel? newsFeaturesModel;
  List<NewsCommentsModel>? newsComments;
  List<PaginatedNewsModel>? relatedHappeningModel = [];
  final ScreenshotController screenshotController = ScreenshotController();

  List? pc;
  List? delCom;
  List? newCom;
  List? replyCom;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<NewsDetailScreenCubit>(context);
    _cubit.getIdWiseNewsDetails(widget.newsId, widget.catId);
    super.initState();
  }

  void speak(String text) async {
    await _tts.setPitch(0.8);
    await _tts.setVolume(1.0);
    await _tts.setLanguage("en-US");
    await _tts.speak(text);
  }

  Future<void> takeScreenshot(BuildContext context) async {
    final imageFile = await screenshotController.capture(
        pixelRatio: MediaQuery
            .of(context)
            .devicePixelRatio);
    if (imageFile != null) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return ImagePreviewBottomSheet(
            image: imageFile,
            onSaveImage: () async {
              final result = await ImageGallerySaver.saveImage(imageFile);
              if (result['isSuccess']) {
                // final savedPath = result['filePath'];
                // print('Screenshot saved to gallery: $savedPath');
                Navigator.pop(context);
                MethodUtils.toast('Image Saved');
              } else {
                MethodUtils.toast('Failed to save screenshot to gallery');
              }
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsDetailScreenCubit, NewsDetailScreenState>(
        builder: (BuildContext context, state) {
          if (state is NewsDetailsLoaded) {
            detailsById = state.newsDetailByIdModel;
            newsComments = state.newsCommentsModel ?? [];
            newsFeaturesModel = state.newsFeaturesModel;
            relatedHappeningModel = state.relatedHappeningModel ?? [];
            pc = state.pComment ?? [];
            delCom = state.delComment ?? [];
            newCom = state.updateComment ?? [];
            replyCom = state.replyComment ?? [];

            return body();
          } else if (state is DetailsScreenInitial) {
            return AppLoaderProgress();
          } else if (state is DetailsScreenLoading) {
            return Stack(
              children: [AppLoaderProgress()],
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
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    int rating = detailsById?.calculatedRating != null
        ? int.parse(detailsById!.calculatedRating!.split('.').first)
        : 0;

    return WillPopScope(
      onWillPop: () async {
        openScreenAsBottomToTop(BottomNavigation(showValue: 2,));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          elevation: 3,
          shadowColor: Colors.grey,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                openScreenAsBottomToTop(BottomNavigation(showValue: 2,));
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            'DETAILS',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return DownloadBottomSheet(
                        newsModel: detailsById!,
                        onDownloadImage: () {
                          takeScreenshot(context);
                        },
                        onDownloadPDF: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewerScreen(
                                          pdfUrl: detailsById?.pdfFileLink ??
                                              '')));
                        },
                      );
                    },
                  );
                },
                icon: Icon(Icons.download_rounded))
          ],
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                                items:
                                detailsById?.imageFileNames?.map((model) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          debugPrint("Show Details");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewImageScreen(
                                                          imgUrl: model
                                                              .toString())));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    child: ImageFiltered(
                                                      imageFilter:
                                                      ImageFilter.blur(
                                                          sigmaX: 10,
                                                          sigmaY: 10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                        model.toString(),
                                                        imageBuilder: (context,
                                                            imageProvider) =>
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                image: DecorationImage(
                                                                    image:
                                                                    imageProvider,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return Center(
                                                              child: Image
                                                                  .asset(
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
                                                  imageUrl: model.toString(),
                                                  imageBuilder: (context,
                                                      imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit
                                                                  .contain),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Center(
                                                        child: Image.asset(
                                                            'assets/no_image_found.jpg'));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                  GestureDetector(
                                    onTap: () {
                                      debugPrint("Youtube");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  YoutubePlayerScreen(
                                                      videoUrl: detailsById
                                                          ?.youtubeVideoLink
                                                          ?.toString() ??
                                                          '')));
                                    },
                                    child: Image.asset(
                                      'assets/youtube.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  reading == false
                                      ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        reading = true;
                                      });
                                      debugPrint("Play");
                                      speak(
                                          detailsById!.title.toString() +
                                              detailsById!.description
                                                  .toString());
                                    },
                                    child: Image.asset(
                                      'assets/text_to_speech.png',
                                      width: 35.0,
                                      height: 35.0,
                                    ),
                                  )
                                      : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        reading = false;
                                      });
                                      debugPrint("stop");
                                      _tts.stop();
                                    },
                                    child: Image.asset(
                                      'assets/stop_record.png',
                                      width:
                                      35.0, // Set the width of the icon
                                      height:
                                      35.0, // Set the height of the icon
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              final newRating = await showModalBottomSheet<int>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return RatingBottomSheet(
                                    cubit: _cubit,
                                    newsId: detailsById?.id ?? 0,
                                    catId: widget.catId,
                                  );
                                },
                              );

                              if (newRating != null) {
                                setState(() {
                                  rating = newRating;
                                });
                              }
                            },
                            child: Wrap(
                              spacing: 0,
                              children: List.generate(5, (index) {
                                final isGolden = index < rating;
                                return Icon(
                                  Icons.star,
                                  color: isGolden ? Colors.amber : Colors.grey,
                                );
                              }),
                            ),
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
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              commentsAndStats(),
              relatedHappenings(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery
              .of(context)
              .viewInsets,
          child: CommentBottomBar(
              controller: commentController,
              onSend: () {
                // Call the method to post the comment
                _cubit.postComment(
                    widget.newsId, commentController.text, widget.catId);

                // Clear the text field after posting the comment
                commentController.clear();
                setState(() {});
              }),
        ),
      ),
    );
  }

  commentSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: newsComments?.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          newsComments?[i].profileImage?.toString() ?? ''),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newsComments?[i].name?.toString() ?? '',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    newsComments?[i].comment?.toString() ?? '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'time ago',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Like',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReplyScreen(
                                                newsDetailScreenCubit: _cubit,
                                                catId: widget.catId,
                                                newsId: widget.newsId,
                                                newsComId: newsComments?[i]
                                                    .commentId ??
                                                    0,
                                                comment: newsComments![i],
                                              )));
                                },
                                child: Text(
                                  'Reply',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return UpdateCommentBottomSheet(
                                        oldComment:
                                        newsComments![i].comment.toString(),
                                        cubit: _cubit,
                                        commentId:
                                        newsComments?[i].commentId ?? 0,
                                        categoryId: widget.catId,
                                        newsId: widget.newsId,
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width: 100,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    'XpressLite',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'Are you Sure? You want to delete this comment.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context, false);
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 100,
                                                            child: Text(
                                                              'No',
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context, true);
                                                            _cubit
                                                                .deleteComment(
                                                              widget.newsId,
                                                              widget.catId,
                                                              newsComments?[i]
                                                                  .commentId ??
                                                                  0,
                                                              '',
                                                            );
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 100,
                                                            child: Text(
                                                              'Yes',
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .orange,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (newsComments![i].replies!.isNotEmpty)
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newsComments?[i].replies?.length,
                    itemBuilder: (BuildContext context, int j) {
                      return Padding(
                        padding: EdgeInsets.only(left: 40, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18.0,
                              backgroundImage: NetworkImage(newsComments![i]
                                  .replies?[j]
                                  .profileImage
                                  ?.toString() ??
                                  ''),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            newsComments![i]
                                                .replies?[j]
                                                .name
                                                ?.toString() ??
                                                '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: SizeConfig.screenWidth * 0.4,
                                            child: Text(
                                              newsComments![i]
                                                  .replies?[j]
                                                  .commentsReply
                                                  ?.toString() ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  relatedHappenings() {
    return Container(
      width: SizeConfig.screenWidth,
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
                          newsDetailScreenCubit: _cubit,
                          eventValue: relatedHappeningModel![index]),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  commentsAndStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NewsFeatureWidget(
              iconData: Icons.thumb_up,
              iconColor: Colors.orange,
              value: newsFeaturesModel?.totalLikes,
              onPressed: () {},
            ),
            NewsFeatureWidget(
              iconData: Icons.comment,
              iconColor: Colors.blue,
              value: newsComments?.length ?? 0,
              onPressed: () {},
            ),
            NewsFeatureWidget(
              iconData: Icons.remove_red_eye,
              iconColor: Colors.blue,
              value: newsFeaturesModel?.totalViews,
              onPressed: () {},
            ),
            if (detailsById?.shareable == true)
              NewsFeatureWidget(
                iconData: Icons.share,
                iconColor: Colors.blue,
                labelText: "Share",
                onPressed: () {},
              ),
            if (detailsById?.downloadable == true)
              NewsFeatureWidget(
                iconData: Icons.picture_as_pdf_outlined,
                iconColor: Colors.red,
                labelText: "View PDF",
                onPressed: () {},
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
              Visibility(visible: showComment, child: commentSection())
            ],
          )
      ],
    );
  }
}
