import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/Widget/customWidget/custom_card.dart';
import 'package:xpresslite/helper/custom_widgets/app_circular_loader.dart';
import 'package:xpresslite/screens/home/cubit/home_cubit.dart';
import 'package:xpresslite/screens/home/cubit/home_state.dart';
import 'package:xpresslite/screens/newsDetails/news_details_screen.dart';
import 'package:xpresslite/screens/view_image/view_image_screen.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/dxWidget/drawer.dart';
import '../../model/UpcomingEventBannerModel.dart';
import '../../model/categorised_news_detail_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late HomeCubit _cubit;

  List<CategorisedNewsDetailsModel> newsDetailsModel = [];

  List<EventBannerModel> eventBannerModel = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<HomeCubit>(context);
    _cubit.getCategoryWiseNewsDetails();
    _cubit.getEventBanner();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
      if (state is HomeLoaded) {
        newsDetailsModel = state.newsDetailsModel ?? [];
        return body();
      } else if (state is EventBannerLoaded) {
        eventBannerModel = state.eventModel ?? [];
      } else if (state is HomeInitial) {
        return body();
      } else if (state is HomeLoading) {
        return Stack(
          children: [body(), const AppLoaderProgress()],
        );
      } else if (state is HomeError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubit.refresh();
        },
      );
    }, listener: (BuildContext context, state) {
      if (state is HomeError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is HomeLoaded) {}
    });
  }

  body() {
    return Scaffold(
      //bottomNavigationBar: BottomNav(),
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Align(alignment: Alignment.center, child: Text('XpressLite')),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Image.asset('assets/social_media.png'), onPressed: () {}),
          IconButton(
              onPressed: () {
                debugPrint("Help");
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.orange,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: newsDetailsModel.map((model) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  debugPrint("Show Details");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => NewsDetailsScreen(newsId: model.id.toString() ,)));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Image.network(
                                          model.imageFileNames.toString(),
                                          fit: BoxFit.cover,
                                          height: 200.0,
                                          width: double.infinity,
                                        )),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15.0),
                                              bottomRight: Radius.circular(15.0)),
                                        ),
                                        child: Text(
                                          model.title.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          // autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: newsDetailsModel.map((model) {
                          int index = newsDetailsModel.indexOf(model);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.orange
                                  : Colors.grey.shade400,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text('Latest Happenings'),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: newsDetailsModel.length,
              itemBuilder: (context, index) {
                return CustomCard(eventValue: newsDetailsModel[index]);
              },
            ),
            Text('Upcoming Events'),
            SizedBox(height: 10),
            Stack(children: [
              Container(
                child: Image(image: AssetImage('assets/bg_event.png')),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CarouselSlider(
                  items: eventBannerModel.map((model) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViewImageScreen(imgUrl: model.imageFileName.toString())));
                            },
                            child: Image.network(
                              model.imageFileName.toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    // autoPlay: true,
                    animateToClosest: true,
                    height: 170,
                    aspectRatio: 1 / 1,
                    //viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ]),

          ],
        ),
      ),
    );
  }
}
