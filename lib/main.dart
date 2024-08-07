import 'package:encrypt_shared_preferences/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:xpresslite/helper/app_utilities/size_reziser.dart';
import 'package:xpresslite/helper/routeAndBlocManager/blocProvider.dart';
import 'package:xpresslite/screens/appNavBar.dart';
import 'package:xpresslite/screens/splash_screen.dart';

import 'helper/notification/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EncryptedSharedPreferences.initialize("aee76tcd965a4bbn");
  await Firebase.initializeApp();
  await setupFCMListeners();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: BlocManager.blocProviders,
      child: GetMaterialApp(
        title: '',
        navigatorKey: navigatorKey,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        
        home: SplashScreen()
      ),
    );
  }
}
