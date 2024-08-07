import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpresslite/helper/localStorage/prefKeys.dart';
import 'package:xpresslite/screens/Dashboard/BottomNav/bottomNav.dart';
import 'package:xpresslite/screens/category/category_screen.dart';
import 'package:xpresslite/screens/appNavBar.dart';
import 'package:xpresslite/screens/home_controller.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/reports/reports_screen.dart';
import '../app_utilities/app_images.dart';
import '../custom_widgets/dailog/Logout.dart';
import '../localStorage/preference_handler.dart';
import '../routeAndBlocManager/navigator.dart';
import 'dx_text.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  String? name;
  String? profileImage;

  Future<void> userDetails() async {
    name = await PreferenceHandler.getName();
    profileImage = await PreferenceHandler.getUserImage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/bg_side_menu_vertical.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                      backgroundImage: NetworkImage(profileImage ??
                          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D"),
                      radius: 40),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DxTextBlack("Hello!"),
                      const SizedBox(width: 5),
                      DxTextBlack(
                        name ?? '',
                        mSize: 18,
                        mBold: true,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: drawerList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      final data = drawerList[i];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: data.icon,
                            title: DxText(
                              data.name,
                              mBold: true,
                            ),
                            onTap: () => navigateTo(data.name),
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ],
      )),
    );
  }

  navigateTo(String name) {
    if (name == "Logout") {
      showLogoutDialog();
    } else if (name == "Categories") {
      openScreenForDrawer(BottomNavigation(
        showValue: 0,
      ));
    } else if (name == "Favourites") {
      openScreenForDrawer(BottomNavigation(
        showValue: 3,
      ));
    } else if (name == "Xpress Bulletin") {
      openScreenForDrawer(BottomNavigation(
        showValue: 4,
      ));
    } else if (name == "Upcoming Events") {
      // openScreenAsBottomToTop(
      //    AuthenticationScreen());
    } else if (name == "Reports") {
      openScreenForDrawer(ReportsScreen());
    } else if (name == "Profile") {
      openScreenForDrawer(ProfileScreen());
    } else {}
  }

  showLogoutDialog() =>
      showDialog(context: context, builder: (_) => LogoutDailog());
}

List<DrawerModel> drawerList = [
  DrawerModel(
      icon: Icon(
        Icons.category_outlined,
        color: Colors.black,
      ),
      name: "Categories"),
  DrawerModel(
      icon: Icon(
        Icons.favorite,
        color: Colors.black,
      ),
      name: "Favourites"),
  DrawerModel(
      icon: Icon(
        Icons.newspaper_outlined,
        color: Colors.black,
      ),
      name: "Xpress Bulletin"),
  DrawerModel(
      icon: Icon(
        Icons.calendar_month_outlined,
        color: Colors.black,
      ),
      name: "Upcoming Events"),
  DrawerModel(
      icon: Icon(
        Icons.pie_chart,
        color: Colors.black,
      ),
      name: "Reports"),
  DrawerModel(
      icon: Icon(
        Icons.person,
        color: Colors.black,
      ),
      name: "Profile"),
  DrawerModel(
      icon: Icon(
        Icons.logout,
        color: Colors.red,
      ),
      name: "Logout"),
  DrawerModel(
      icon: Icon(
        Icons.file_download,
        color: Colors.red,
      ),
      name: "App Version v1.0"),
];

class DrawerModel {
  Icon icon;
  String name;

  DrawerModel({required this.icon, required this.name});
}
