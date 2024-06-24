import 'package:flutter/src/widgets/framework.dart';
import 'package:xpresslite/constants/images.dart';
import 'package:xpresslite/constants/strings.dart';
import 'package:xpresslite/screens/allPdfs/AllPdfScreen.dart';
import 'package:xpresslite/screens/focusedCategory/focused_category_screen.dart';

import '../screens/categorizedNews/Cat_news_screen.dart';
import '../screens/category/InsideCategory/directors_category_screen.dart';
import '../screens/category/InsideCategory/Category3_screen.dart';

const CategoryListImage = [
  cat1,
  cat2,
  cat3,
  cat4,
  cat5,
  cat6,
  cat7,
  cat8,
  cat9,
];

const CategoryListTitle = [
  chairmanMsg,
  directorMsg,
  awardsRecognition,
  happenings,
  focusedCategory,
  knowledgeCenter,
  indianOilNews,
  xpresNewsArchive,
  specialBulletins
];

List<Widget> insideCategory = [
  AllPdfScreen(appBarTitle: chairmanMsg, CatId: 2, DirId: null,),
  const DirectorsCategoryScreen(),
  CategoryNewsScreen(catId: '5', appBarTitle: awardsRecognition,),
  CategoryNewsScreen(catId: '4', appBarTitle: happenings,),
  FocusedCategoryScreen(),
  CategoryNewsScreen(catId: '243', appBarTitle: knowledgeCenter,),
  CategoryNewsScreen(catId: '9', appBarTitle: indianOilNews,),
  CategoryNewsScreen(catId: '7', appBarTitle: xpresNewsArchive,),
  CategoryNewsScreen(catId: '8', appBarTitle: specialBulletins,),
];

const directorsBg = [
  marketing,
  refineries,
  planning,
  pipeline,
  finance,
  researchDev
];
