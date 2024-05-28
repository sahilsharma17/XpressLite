import 'dart:async';

import 'package:flutter/material.dart';

import 'slide_dots.dart';
import 'slide_item.dart';


class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 35),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for(int i = 0; i<slideList.length; i++)
                                if( i == _currentPage )
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text(
              //         'Getting Started',
              //         style: TextStyle(
              //           fontSize: 18,
              //         ),
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       padding: const EdgeInsets.all(15),
              //       color: Theme.of(context).primaryColor,
              //       textColor: Colors.white,
              //       onPressed: () {
              //         openScreenAsPlatformWiseRoute(context, RegisterScreen(),isExit: true);
              //
              //       },
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Text(
              //           'Have an account?',
              //           style: TextStyle(
              //             fontSize: 18,
              //           ),
              //         ),
              //         FlatButton(
              //           child: Text(
              //             'Login',
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           onPressed: () {
              //             openScreenAsPlatformWiseRoute(context, LoginScreen(),isExit: true);
              //           },
              //         ),
              //       ],
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
      imageUrl: 'assets/images/asset1.png',
      title: 'Travel Claim & Reimbursement ',
      description:
      'Comprehensive travel and expense management solution, for both local and international travels.'),
  Slide(
      imageUrl: 'assets/images/asset2.png',
      title: 'Geo-Fencing',
      description:
      'Allow the employee to punch only within a marked periphery.'),
  Slide(
      imageUrl: 'assets/images/asset3.png',
      title: 'Attendance,Shifts & Leave Mangament',
      description:
      'Mangage attendanceModule,leave and shift effectively fully integrated with bio-metric machine'),
  Slide(
      imageUrl: 'assets/images/asset4.png',
      title: 'Punch Using Face Recognition',
      description:
      'Attendance via face verification for enhanced hygiene during covid'),
];
