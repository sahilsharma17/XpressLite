import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/Widget/customWidget/custom_card.dart';
import 'package:xpresslite/helper/custom_widgets/app_circular_loader.dart';
import 'package:xpresslite/screens/home/cubit/home_cubit.dart';
import 'package:xpresslite/screens/home/cubit/home_state.dart';
import 'package:xpresslite/screens/newsDetails/news_details_screen.dart';
import 'package:xpresslite/screens/view_image/view_image_screen.dart';

import '../../Widget/customWidget/custom_card2.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/dxWidget/drawer.dart';
import '../../model/PaginatedNewsModel .dart';
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

  List<NewsBannerModel> newsBannersModel = [];

  List<EventBannerModel> eventBannerModel = [];

  List<PaginatedNewsModel>? pageNewsModel = [];

  List<PaginatedNewsModel>? pageAwardsRecoModel = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<HomeCubit>(context);
    _cubit.getNewsBanner();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
      if (state is HomeLoaded) {
        newsBannersModel = state.newsBannerModel ?? [];
        pageNewsModel = state.pHappeningModel ?? [];
        eventBannerModel = state.eventModel ?? [];
        pageAwardsRecoModel = state.pAwardRecoModel ?? [];

        return body();
      } else if (state is HomeInitial) {
        return body();
      } else if (state is HomeLoading) {
        return Stack(
          children: [const AppLoaderProgress()],
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
                        items: newsBannersModel.map((model) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  debugPrint("Show Details");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailsScreen(
                                                newsId: model.id.toString(),
                                              )));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              model.imageFileNames.toString(),
                                          fit: BoxFit.cover,
                                          height: 200.0,
                                          width: double.infinity,
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
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
                                              bottomRight:
                                                  Radius.circular(15.0)),
                                        ),
                                        child: Text(
                                          model.title.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                        children: newsBannersModel.map((model) {
                          int index = newsBannersModel.indexOf(model);
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pageNewsModel?.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    children: [
                      CustomCard(eventValue: pageNewsModel![index]),
                    ],
                  ),
                );
              },
            ),
            Text('Upcoming Events'),
            Stack(children: [
              Container(
                child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.2, 0.2),
                          blurRadius: 0.2,
                          spreadRadius: 0.2)
                    ]),
                    child: Image(image: AssetImage('assets/bg_event.png'))),
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
                                  MaterialPageRoute(
                                      builder: (context) => ViewImageScreen(
                                          imgUrl:
                                              model.imageFileName.toString())));
                            },
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 170,
                                width: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0.2, 0.2),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.2)
                                  ],
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                              imageUrl: model.imageFileName.toString(),
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                ),
                              ),
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
                    // aspectRatio: 1 / 1,
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
            Text('Awards & Recognitions'),
            SizedBox(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: pageAwardsRecoModel?.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.2),
                        child: CustomCard2(eventValue: pageAwardsRecoModel![index]),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
