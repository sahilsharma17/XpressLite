import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/Widget/customWidget/custom_card.dart';
import 'package:xpresslite/model/PaginatedNewsModel.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import 'cubit/favs_screen_cubit.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late FavsScreenCubit _cubit;
  late List<PaginatedNewsModel> newsModel;

  @override
  void initState() {
    _cubit = BlocProvider.of<FavsScreenCubit>(context);
    _cubit.getNewsFavs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAVOURITES',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<FavsScreenCubit, FavsScreenState>(
        builder: (BuildContext context, state) {
          if (state is FavsScreenLoaded) {
            newsModel = state.newsModel;
            return body();
          } else if (state is FavsScreenInitial || state is FavsScreenLoading) {
            return AppLoaderProgress();
          } else if (state is FavsScreenError) {
            return body();  // Assuming body() can handle empty or error states
          }
          return AccessDeniedScreen(
            onPressed: () {
              // Handle access denied case
            },
          );
        },
        listener: (BuildContext context, state) {
          if (state is FavsScreenError && state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          }
        },
      ),
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: newsModel.length,
      itemBuilder: (context, index) {
        return CustomCard(
          eventValue: newsModel[index],
          favCubit: _cubit,  // Pass the favCubit to CustomCard
        );
      },
    );
  }
}
