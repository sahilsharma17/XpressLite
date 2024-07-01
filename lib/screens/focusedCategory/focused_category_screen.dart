import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/focusedCatModel.dart';
import 'package:xpresslite/screens/focusedCategory/cubit/focused_cat_cubit.dart';
import 'package:xpresslite/screens/focusedCategory/cubit/focused_cat_state.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../categorizedNews/Cat_news_screen.dart';

class FocusedCategoryScreen extends StatefulWidget {
  const FocusedCategoryScreen({super.key});

  @override
  State<FocusedCategoryScreen> createState() => _FocusedCategoryScreenState();
}

class _FocusedCategoryScreenState extends State<FocusedCategoryScreen> {
  late FocusedCategoryScreenCubit _cubit;

  List<FocusedCategoryModel>? focusCat = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<FocusedCategoryScreenCubit>(context);
    _cubit.getFocusedCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'FOCUSED CATEGORY',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<FocusedCategoryScreenCubit, FocusedCategoryState>(
          builder: (BuildContext context, state) {
        if (state is FocusedCategoryLoaded) {
          focusCat = state.focusedCategory ?? [];

          return body();
        } else if (state is FocusedCategoryInitial) {
          return AppLoaderProgress();
        } else if (state is FocusedCategoryLoading) {
          return Stack(
            children: [AppLoaderProgress()],
          );
        } else if (state is FocusedCategoryError) {
          return body();
        }
        return AccessDeniedScreen(
          onPressed: () {
            _cubit.getFocusedCategories();
          },
        );
      }, listener: (BuildContext context, state) {
        if (state is FocusedCategoryError) {
          if (state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          }
        } else if (state is FocusedCategoryLoaded) {}
      }),
    );
  }

  body() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: focusCat?.length,
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryNewsScreen(
                                catId: focusCat![i].id.toString(),
                                appBarTitle:
                                    focusCat![i].topic.toString().toUpperCase(),
                              )));
                },
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/circled_menu.png',
                            width: 20, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            focusCat?[i].topic.toString() ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
