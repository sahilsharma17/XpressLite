import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/directorsCatModel.dart';
import 'package:xpresslite/screens/allPdfs/AllPdfScreen.dart';
import 'package:xpresslite/screens/category/InsideCategory/cubit/directors_category_cubit.dart';
import 'package:xpresslite/screens/category/InsideCategory/cubit/directors_category_state.dart';

import '../../../constants/lists.dart';
import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../../helper/custom_widgets/app_circular_loader.dart';

class DirectorsCategoryScreen extends StatefulWidget {
  const DirectorsCategoryScreen({super.key});

  @override
  State<DirectorsCategoryScreen> createState() =>
      _DirectorsCategoryScreenState();
}

class _DirectorsCategoryScreenState extends State<DirectorsCategoryScreen> {
  late DirectorsCategoryCubit _cubit;

  List<DirectorCatModel> directorModel = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<DirectorsCategoryCubit>(context);
    _cubit.getDirectors();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DirectorsCategoryCubit, DirectorsCategoryState>(
        builder: (BuildContext context, state) {
      if (state is DirectorsCategoryLoaded) {
        directorModel = state.directorCatModel ?? [];

        return body();
      } else if (state is DirectorsCategoryInitial) {
        return body();
      } else if (state is DirectorsCategoryLoading) {
        return Stack(
          children: [const AppLoaderProgress()],
        );
      } else if (state is DirectorsCategoryError) {
        return body();
      }
      return AccessDeniedScreen(
        onPressed: () {
          _cubit.refresh();
        },
      );
    }, listener: (BuildContext context, state) {
      if (state is DirectorsCategoryError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is DirectorsCategoryLoaded) {}
    });
  }

  body() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "DIRECTOR'S MESSAGE",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 10,
              mainAxisExtent: 255,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllPdfScreen(appBarTitle: directorModel[index].directorName, id: directorModel[index].id,)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1.0, // Border width
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  directorsBg[index],
                                  width: 200,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 40,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: (directorModel[index]
                                      .directorImage
                                      .toString()),
                                  width: 100.0,
                                  // Diameter
                                  height: 100.0,
                                  // Diameter
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(color: Colors.orange,),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${directorModel[index].directorName}  ${directorModel[index].directorType}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
