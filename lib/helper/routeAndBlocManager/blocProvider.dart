import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xpresslite/screens/allPdfs/cubit/allpdfs_cubit.dart';
import 'package:xpresslite/screens/auth/cubit/login_cubit.dart';
import 'package:xpresslite/screens/bulletin/cubit/bulletin_cubit.dart';
import 'package:xpresslite/screens/categorizedNews/cubit/cat_news_cubit.dart';
import 'package:xpresslite/screens/category/InsideCategory/cubit/directors_category_cubit.dart';
import 'package:xpresslite/screens/focusedCategory/cubit/focused_cat_cubit.dart';
import 'package:xpresslite/screens/home/cubit/home_cubit.dart';
import 'package:xpresslite/screens/reports/cubit/reports_cubit.dart';

import '../../screens/explore/cubit/explore_screen_cubit.dart';
import '../../screens/newsDetails/cubit/news_detail_cubit.dart';


class BlocManager {
  static List<SingleChildWidget> get blocProviders => [
    BlocProvider(create: (context) => LoginCubit()),
    BlocProvider(create: (context) => HomeCubit()),
    BlocProvider(create: (context) => NewsDetailScreenCubit()),
    BlocProvider(create: (context) => DirectorsCategoryCubit()),
    BlocProvider(create: (context) => PdfsCubit()),
    BlocProvider(create: (context) => CatNewsScreenCubit()),
    BlocProvider(create: (context) => FocusedCategoryScreenCubit()),
    BlocProvider(create: (context) => ExploreScreenCubit()),
    BlocProvider(create: (context) => ReportsCubit()),
    BlocProvider(create: (context) => BulletinCubit()),
  ];
}
