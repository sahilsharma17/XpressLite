import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../app_utilities/app_theme.dart';
import '../../dxWidget/dx_text.dart';
import 'dotIndicator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageSliderWidget extends StatefulWidget {
  // final List<String> imageUrls;
  final List<String> allbanner;
  final BorderRadius imageBorderRadius;
  final double imageHeight;
  final double imagePadding;
  final double aspectRatio;
  final int activeIndex;
  final int delayTimeInSecond;
  final bool isVisible;

  const ImageSliderWidget({
    Key? key,
    required this.imageBorderRadius,
    required this.allbanner,
    required this.isVisible,
    this.imageHeight = 170.0,
    this.imagePadding = 2,
    this.activeIndex = 0,
    this.aspectRatio = 0,
    this.delayTimeInSecond = 5,
  }) : super(key: key);

  @override
  ImageSliderWidgetState createState() => ImageSliderWidgetState();
}

class ImageSliderWidgetState extends State<ImageSliderWidget> {
  List<Widget> _pages = [];

  int page = 0;
  int _currentPage = 0;

  final _controller = PageController();
  Timer? timer;

  @override
  void initState() {
    _currentPage = widget.activeIndex;
    _pages = widget.allbanner.map((banner) {
      return _buildImagePageItem(banner);
    }).toList();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateToPage(_currentPage,
            duration: Duration(milliseconds: 1), curve: Curves.easeIn);
        timer = Timer.periodic(Duration(seconds: widget.delayTimeInSecond),
                (Timer timer) {
              if (_currentPage < _pages.length - 1) {
                _currentPage++;
              } else {
                _currentPage = 0;
              }
              _controller.animateToPage(
                _currentPage,
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
            });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _buildingImageSlider();
  }

  Widget _buildingImageSlider() {
    // return widget.imageHeight > 0
    //     ? AspectRatio(
    //   aspectRatio:
    //   widget.aspectRatio == 0 ? (24 / 12) : widget.aspectRatio,
    //   child: Container(
    //     color: Colors.yellow,
    //          height: widget.imageHeight,
    //     child: Card(
    //       shape: RoundedRectangleBorder(
    //           borderRadius: widget.imageBorderRadius),
    //       elevation: 0,
    //       child: Stack(
    //         children: [
    //           _buildPagerViewSlider(),
    //           _buildDotsIndicatorOverlay(),
    //         ],
    //       ),
    //     ),
    //   ),
    // )
    //     :
   return Container(
     height: widget.imageHeight,
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: widget.imageBorderRadius
      ),
      padding: EdgeInsets.all(widget.imagePadding),
      child: Stack(
        children: [
          _buildPagerViewSlider(),
          _buildDotsIndicatorOverlay(),
        ],
      ),
    );
  }

  Widget _buildPagerViewSlider() {
    return Positioned.fill(
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index % _pages.length];
        },
        onPageChanged: (int p) {
          setState(() {
            page = p;
            _currentPage = p;
          });
        },
      ),
    );
  }
  
  Positioned nameWidget(String name){
    return  Positioned(
    bottom:20,
    left: 1,
    right: 1,
    child: Container(
      height: 40,
      color: Colors.white60,
      alignment: Alignment.center,
      child: DxTextBlack(name,mSize: 18,mBold: true,),));
  }

  Positioned _buildDotsIndicatorOverlay() {
    return Positioned(
      bottom: 2.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DotsIndicator(
          color: materialAccentColor,
          controller: _controller,
          itemCount: _pages.length,
          onPageSelected: (int page) {
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }

  Widget _buildImagePageItem(String banner) {
    //print("=>>"+imgUrl);
    return Stack(
      fit: StackFit.expand,
      children: [
      InkWell(
          onTap: (){

          },
          child: ClipRRect(
            borderRadius: widget.imageBorderRadius,
            child: banner.startsWith("http")
                ? CachedNetworkImage(
              imageUrl: banner,
              // imageUrl: "https://www.studentadvisorbooks.in/images/slider-4.jpg",
              placeholder: (context, url) => Center(
                child: (!kIsWeb && Platform.isIOS)
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
//        fit: widget.imageHeight > 0 ? BoxFit.cover : BoxFit.fitWidth,
            )
                : Image.asset(
              banner,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          )
      ),
        Visibility(
            child: nameWidget("Chairman extends gettings on 59th national day."),
          visible: widget.isVisible,
        )
    ],);
  }


}
