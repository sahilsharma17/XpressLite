import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/helper/app_utilities/size_reziser.dart';
import 'package:xpresslite/model/AllRatersModel.dart';
import 'package:xpresslite/screens/rating/cubit/all_ratings_cubit.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';

class RatingScreen extends StatefulWidget {
  int newsId;

  RatingScreen({required this.newsId, super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late AllRatingsCubit _cubit;

  List<AllRatingModel>? allRaters = [];

  bool isRated = false;

  @override
  void initState() {
    _cubit = BlocProvider.of<AllRatingsCubit>(context);
    _cubit.getAllRaters(widget.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            'RATING',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 3,
          shadowColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<AllRatingsCubit, AllRatingsState>(
          builder: (BuildContext context, state) {
            if (state is AllRatingsLoaded) {
              allRaters = state.allRaters ?? [];
              return body();
            } else if (state is AllRatingsInitial ||
                state is AllRatingsLoading) {
              return AppLoaderProgress();
            } else if (state is AllRatingsError) {
              return body();
            }
            return AccessDeniedScreen(
              onPressed: () {
                // Handle access denied case
              },
            );
          },
          listener: (BuildContext context, state) {
            if (state is AllRatingsError && state.error.isNotEmpty) {
              MethodUtils.toast(state.error);
            }
          },
        ),
      ),
    );
  }

  body() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: allRaters?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.grey.shade300,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          NetworkImage(allRaters?[index].profileImage ?? ''),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allRaters?[index].name ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '( ${allRaters![index].divisionName} | ${allRaters?[index].location} )',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(),
                    Wrap(
                      spacing: 0,
                      children: List.generate(5, (i) {
                        final isRated = i < (allRaters?[index].newsRated ?? 0);
                        return Icon(
                          Icons.star,
                          size: 16,
                          color: isRated
                              ? Colors.grey.shade700
                              : Colors.grey.shade400,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
