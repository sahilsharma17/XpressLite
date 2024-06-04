import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xpresslite/screens/auth/cubit/login_cubit.dart';
import 'package:xpresslite/screens/home/cubit/home_cubit.dart';

import '../../screens/newsDetails/cubit/news_detail_cubit.dart';


class BlocManager {
  static List<SingleChildWidget> get blocProviders => [
    BlocProvider(create: (context) => LoginCubit()),
    BlocProvider(create: (context) => HomeCubit()),
    BlocProvider(create: (context) => NewsDetailCubit()),
  ];
}
