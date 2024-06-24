import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/screens/categorizedNews/cubit/cat_news_cubit.dart';
import 'package:xpresslite/screens/categorizedNews/cubit/cat_news_state.dart';

import '../../Widget/customWidget/custom_card.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/PaginatedNewsModel .dart';

class CategoryNewsScreen extends StatefulWidget {
  String catId;
  String appBarTitle;

  CategoryNewsScreen({super.key, required this.catId,  required this.appBarTitle});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  late CatNewsScreenCubit _cubit;

  List<PaginatedNewsModel>? newsByCat = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<CatNewsScreenCubit>(context);
    _cubit.getRelatedNews(widget.catId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatNewsScreenCubit, CatNewsScreenState>(
        builder: (BuildContext context, state) {
      if (state is CatNewsScreenLoaded) {
        newsByCat = state.newsByCategory ?? [];

        return body();
      } else if (state is CatNewsScreenInitial) {
        return AppLoaderProgress();
      } else if (state is CatNewsScreenLoading) {
        return Stack(
          children: [const AppLoaderProgress()],
        );
      } else if (state is CatNewsScreenError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubit.getRelatedNews(widget.catId);
        },
      );
    }, listener: (BuildContext context, state) {
      if (state is CatNewsScreenError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is CatNewsScreenLoaded) {}
    });
  }

  body() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(widget.appBarTitle,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: newsByCat?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CustomCard(eventValue: newsByCat![index]),
              ],
            );
          },
        ),
      ),
    );
  }
}
