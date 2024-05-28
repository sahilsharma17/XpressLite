import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/Widget/customWidget/custom_card.dart';
import 'package:xpresslite/constants/images.dart';
import 'package:xpresslite/constants/strings.dart';
import 'package:xpresslite/helper/custom_widgets/app_circular_loader.dart';
import 'package:xpresslite/screens/home/eventBanner/cubit/eventBanner_cubit.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/dxWidget/drawer.dart';
import '../../model/UpcomingEventBannerModel.dart';
import '../../model/categorised_news_detail_model.dart';
import 'eventDetails/cubit/getCategoryWiseNewsDetails_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late GetCategoryWiseNewsDetailsCubit _cubitNewsDetails;
  List<CategorisedNewsDetailsModel> newsDetailsModel = [];

  late EventBannerCubit _cubitEventBanner;
  late EventBannerModel eventBannerModel;

  @override
  void initState() {
    _cubitNewsDetails = BlocProvider.of<GetCategoryWiseNewsDetailsCubit>(context);
    _cubitNewsDetails.getCategoryWiseNewsDetails();

    _cubitEventBanner = BlocProvider.of<EventBannerCubit>(context);
    _cubitEventBanner.getEventBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCategoryWiseNewsDetailsCubit,
            GetCategoryWiseNewsDetailsState>(
        builder: (BuildContext context, state) {
      if (state is GetCategoryWiseNewsDetailsLoaded) {
        newsDetailsModel = state.newsDetailsModel ?? [];
        return body();
      }
      else if (state is GetCategoryWiseNewsDetailsInitial) {
        return body();
      } else if (state is GetCategoryWiseNewsDetailsLoading) {
        return Stack(
          children: [body(), const AppLoaderProgress()],
        );
      } else if (state is GetCategoryWiseNewsDetailsError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubitNewsDetails.refresh();
        },
      );
    }, listener: (BuildContext context, state) {
      if (state is GetCategoryWiseNewsDetailsError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is GetCategoryWiseNewsDetailsLoaded) {}
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
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Colors.orange,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: newsDetailsModel.map((model) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
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
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
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
                          return
                            Container(
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              //height: 200,
              color: Colors.black,
              child: Image(
                image: AssetImage('assets/bg_event.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
