import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/screens/filter/filters_screen.dart';
import 'package:xpresslite/screens/newsDetails/news_details_screen.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/searchModel.dart';
import 'cubit/explore_screen_cubit.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late ExploreScreenCubit _cubit;

  List<SearchModel>? searchedNews = [];

  late TextEditingController keyword = TextEditingController();

  @override
  void initState() {
    _cubit = BlocProvider.of<ExploreScreenCubit>(context);
    // _cubit.searchingNews('delhi');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
          child: ExploreBar(),
        ),
        body: BlocConsumer<ExploreScreenCubit, ExploreScreenState>(
          builder: (BuildContext context, state) {
            if (state is ExploreScreenLoaded) {
              searchedNews = state.searchedNewsModel ?? [];
              return body();
            } else if (state is ExploreScreenInitial) {
              return Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Image.asset(
                    'assets/search.gif',
                    height: 200,
                  ),
                ),
              );
            } else if (state is ExploreScreenLoading) {
              return Stack(
                children: [AppLoaderProgress()],
              );
            } else if (state is ExploreScreenError) {
              return body();
            }
            return AccessDeniedScreen(
              onPressed: () {
                _cubit.searchingNews('gurugram');
              },
            );
          },
          listener: (BuildContext context, state) {
            if (state is ExploreScreenError) {
              if (state.error.isNotEmpty) {
                MethodUtils.toast(state.error);
              }
            } else if (state is ExploreScreenLoaded) {}
          },
        ),
      ),
    );
  }

  body() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchedNews!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: MediaQuery.of(context).size.height / 4,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                          newsId: searchedNews![index].id.toString(),
                          catId: searchedNews![index].categoryId.toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.white,
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: (size.height / 5) - 28,
                          width: (size.width / 2) - 12,
                          decoration: const BoxDecoration(color: Colors.white),
                          child:
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: CachedNetworkImage(
                                        imageUrl: searchedNews![index]
                                            .imageFileNames![0]
                                            .toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) {
                                          return Center(
                                              child: Image.asset(
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
                                  imageUrl: searchedNews![index]
                                      .imageFileNames![0]
                                      .toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) {
                                    return Center(
                                        child: Image.asset(
                                            'assets/no_image_found.jpg'));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.orange,
                                    size: 20,
                                  )
                                ],
                              ),
                              Text(
                                searchedNews![index].title.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ExploreBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 16, 16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "EXPLORE",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FiltersScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.filter_list_alt,
                  size: 30,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    cursorColor: Colors.orange,
                    controller: keyword,
                    onChanged: (val) {
                      if (keyword.text.length >= 3) {
                        _cubit.searchingNews(keyword.text);
                      } else if (keyword.text.length <= 2) {
                        setState(() {
                          _cubit.refresh();
                        });
                      } else if (keyword.text.length == 0) {
                        setState(() {
                          _cubit.refresh();
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for happenings.....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.mic,
                  color: Colors.orange,
                  size: 30,
                ),
                onPressed: () {
                  // Mic action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
