import 'package:flutter/material.dart';
import 'package:xpresslite/screens/home/home_screen.dart';

import '../../../helper/dxWidget/drawer.dart';

class BottomNav extends StatefulWidget {
  final int? showVal;

  const BottomNav({
    Key? key,
    this.showVal,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  bool showAppBar = false;
  int _selectedIndex = 0;

  var categoryIcon = Icons.category_outlined;
  var searchIcon = Icons.search_outlined;
  var favIcon = Icons.favorite_border;
  var bulletinsIcon = Icons.newspaper_outlined;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),

    HomeScreen(),

    HomeScreen(),
    HomeScreen(),
    // CompanyDirectory()
  ];

  @override
  void initState() {
    _selectedIndex = widget.showVal ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      //drawer: ,
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
              title: Text(
                "Home",
              ),
            )
          : null,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 80,
                color: Colors.white,
                child: Image(
                  image: AssetImage(
                    'assets/bottom-design.png',
                  ),
                  fit: BoxFit.fitHeight,
                )
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showAppBar = false;
                                    _selectedIndex = 0;
                                    categoryIcon = Icons.category_outlined;
                                    searchIcon = Icons.search_outlined;
                                    favIcon = Icons.favorite_border;
                                    bulletinsIcon = Icons.newspaper_outlined;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.category_outlined)
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Categories",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showAppBar = false;
                                    _selectedIndex = 1;
                                    categoryIcon = Icons.category_outlined;
                                    searchIcon = Icons.search_outlined;
                                    favIcon = Icons.favorite_border;
                                    bulletinsIcon = Icons.newspaper_outlined;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.search_outlined)
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Search",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showAppBar = false;
                        _selectedIndex = 2;
                        categoryIcon = Icons.category_outlined;
                        searchIcon = Icons.search_outlined;
                        favIcon = Icons.favorite_border;
                        bulletinsIcon = Icons.newspaper_outlined;
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 38),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image(
                              height: 40,
                              width: 40,
                              image: AssetImage(
                                'assets/app_logo.png'
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showAppBar = false;
                                    _selectedIndex = 3;
                                    categoryIcon = Icons.category_outlined;
                                    searchIcon = Icons.search_outlined;
                                    favIcon = Icons.favorite_border;
                                    bulletinsIcon = Icons.newspaper_outlined;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.favorite_border)
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Favourites",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showAppBar = false;
                                    _selectedIndex = 4;
                                    categoryIcon = Icons.category_outlined;
                                    searchIcon = Icons.search_outlined;
                                    favIcon = Icons.favorite_border;
                                    bulletinsIcon = Icons.newspaper_outlined;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.newspaper_outlined)
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Bulletins",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
