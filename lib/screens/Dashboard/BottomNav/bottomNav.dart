// import 'package:flutter/material.dart';
// import 'package:xpresslite/screens/home/home_screen.dart';
//
// import '../../../helper/dxWidget/drawer.dart';
//
// class BottomNav extends StatefulWidget {
//   final int? showVal;
//
//   const BottomNav({
//     Key? key,
//     this.showVal,
//   }) : super(key: key);
//
//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }
//
// class _BottomNavState extends State<BottomNav> {
//   bool showAppBar = false;
//   int _selectedIndex = 0;
//
//   var categoryIcon = Icons.category_outlined;
//   var searchIcon = Icons.search_outlined;
//   var favIcon = Icons.favorite_border;
//   var bulletinsIcon = Icons.newspaper_outlined;
//
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   static List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     HomeScreen(),
//
//     HomeScreen(),
//
//     HomeScreen(),
//     HomeScreen(),
//     // CompanyDirectory()
//   ];
//
//   @override
//   void initState() {
//     _selectedIndex = widget.showVal ?? 0;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomDrawer(),
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       //drawer: ,
//       appBar: showAppBar
//           ? AppBar(
//               leading: IconButton(
//                 icon: const Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                 ),
//                 color: Colors.brown,
//                 onPressed: () {
//                   _scaffoldKey.currentState!.openDrawer();
//                 },
//               ),
//               title: Text(
//                 "Home",
//               ),
//             )
//           : null,
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Container(
//                 height: 60,
//                 color: Colors.white,
//                 child: Image(
//                   image: AssetImage(
//                     'assets/bottom-design.png',
//                   ),
//                   fit: BoxFit.fitHeight,
//                 )
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: Container(
//                         height: 60,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     showAppBar = false;
//                                     _selectedIndex = 0;
//                                     categoryIcon = Icons.category_outlined;
//                                     searchIcon = Icons.search_outlined;
//                                     favIcon = Icons.favorite_border;
//                                     bulletinsIcon = Icons.newspaper_outlined;
//                                   });
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Icon(Icons.category_outlined)
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "Categories",
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     showAppBar = false;
//                                     _selectedIndex = 1;
//                                     categoryIcon = Icons.category_outlined;
//                                     searchIcon = Icons.search_outlined;
//                                     favIcon = Icons.favorite_border;
//                                     bulletinsIcon = Icons.newspaper_outlined;
//                                   });
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Icon(Icons.search_outlined)
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "Search",
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         showAppBar = false;
//                         _selectedIndex = 2;
//                         categoryIcon = Icons.category_outlined;
//                         searchIcon = Icons.search_outlined;
//                         favIcon = Icons.favorite_border;
//                         bulletinsIcon = Icons.newspaper_outlined;
//                       });
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             right: 20, left: 20, bottom: 38),
//                         child: Container(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(40.0),
//                             child: Image(
//                               height: 40,
//                               width: 40,
//                               image: AssetImage(
//                                 'assets/app_logo.png'
//                               ),
//                               fit: BoxFit.fitHeight,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       child: Container(
//                         height: 60,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     showAppBar = false;
//                                     _selectedIndex = 3;
//                                     categoryIcon = Icons.category_outlined;
//                                     searchIcon = Icons.search_outlined;
//                                     favIcon = Icons.favorite_border;
//                                     bulletinsIcon = Icons.newspaper_outlined;
//                                   });
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Icon(Icons.favorite_border)
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "Favourites",
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     showAppBar = false;
//                                     _selectedIndex = 4;
//                                     categoryIcon = Icons.category_outlined;
//                                     searchIcon = Icons.search_outlined;
//                                     favIcon = Icons.favorite_border;
//                                     bulletinsIcon = Icons.newspaper_outlined;
//                                   });
//                                 },
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Icon(Icons.newspaper_outlined)
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "Bulletins",
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:xpresslite/screens/bulletin/bulletin_screen.dart';
import 'package:xpresslite/screens/category/category_screen.dart';
import 'package:xpresslite/screens/explore/explore_screen.dart';
import 'package:xpresslite/screens/fav/fav_screen.dart';
import 'package:xpresslite/screens/home/home_screen.dart';
import '../../../helper/app_utilities/app_images.dart';
import '../../../helper/dxWidget/drawer.dart';
import '../../../helper/dxWidget/dx_text.dart';

class BottomNavigation extends StatefulWidget {
  final int? showValue;

  const BottomNavigation({
    Key? key,
    this.showValue,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  bool showAppBar = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static List<Widget> _widgetOptions = <Widget>[
    CategoryScreen(),
    ExploreScreen(),
    HomeScreen(),
    FavScreen(),
    BulletinScreen(),
    // CompanyDirectory()
  ];

  @override
  void initState() {
    _selectedIndex = widget.showValue ?? 0;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      showAppBar = false;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: showAppBar
          ? AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          color: Colors.brown,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: DxTextWhite(
          "Home",
          mBold: true,
          mSize: 14,
        ),
      )
          : null,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              child: InkWell(
                onTap: () => _onItemTapped(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.grid_view,
                      color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    DxTextBlack(
                      "Categories",
                      mBold: true,
                      mSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 60,
              child: InkWell(
                onTap: () => _onItemTapped(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    DxTextBlack(
                      "Search",
                      mBold: true,
                      mSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => _onItemTapped(2),
              child: Container(
                height: 54,
                width: 54,
                child: const CircleAvatar(
                backgroundImage: AssetImage('assets/app_logo.png'),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 60,
              child: InkWell(
                onTap: () => _onItemTapped(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _selectedIndex == 3
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: _selectedIndex == 3 ? Colors.orange : Colors.grey,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    DxTextBlack(
                      "Favourites",
                      mBold: true,
                      mSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 60,
              child: InkWell(
                onTap: () => _onItemTapped(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event,
                      color: _selectedIndex == 4 ? Colors.orange : Colors.grey,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    DxTextBlack(
                      "Bulletins",
                      mBold: true,
                      mSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
