import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpresslite/helper/app_utilities/app_theme.dart';
import 'package:xpresslite/screens/bulletin/bulletin_screen.dart';
import 'package:xpresslite/screens/explore/explore_screen.dart';
import 'package:xpresslite/screens/fav/fav_screen.dart';
import 'package:xpresslite/screens/profile/profile_screen.dart';

import 'category/category_screen.dart';
import 'home/home_screen.dart';
import 'home_controller.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItems = [
      BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
      BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined), label: "Search"),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined), label: 'Favourites'),
      BottomNavigationBarItem(icon: Icon(Icons.newspaper_outlined), label: "Bulletin"),
    ];

    var navBody = [
      CategoryScreen(),
      ExploreScreen(),
      HomeScreen(),
      FavScreen(),
      BulletinScreen(),
    ];

    return Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            elevation: 3,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: navbarItems,
            onTap: (value) {
              controller.currentIndex.value = value;
            },
          ),
        ));
  }
}
