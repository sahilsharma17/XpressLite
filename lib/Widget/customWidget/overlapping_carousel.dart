library overlapped_carousel;

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../model/card.dart';



class OverlappedCarousel extends StatefulWidget {
  final List<Widget> widgets;
  final Function(int) onClicked;
  final int currentIndex;
  final double obscure;
  final double skewAngle;

  OverlappedCarousel({
    required this.widgets,
    required this.onClicked,
    this.currentIndex = 2,
    this.obscure = 0,
    this.skewAngle = -0.25,
  });

  @override
  _OverlappedCarouselState createState() => _OverlappedCarouselState();
}

class _OverlappedCarouselState extends State<OverlappedCarousel> {
  late double currentIndex;
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex.toDouble();
    widgets = [widget.widgets.last, ...widget.widgets, widget.widgets.first];
  }

  void updateCurrentIndex(double newIndex) {
    setState(() {
      if (newIndex <= 0) {
        currentIndex = widgets.length - 2.0;
      } else if (newIndex >= widgets.length - 1) {
        currentIndex = 1.0;
      } else {
        currentIndex = newIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                var indx = currentIndex - details.delta.dx * 0.02;
                updateCurrentIndex(indx);
              });
            },
            onPanEnd: (details) {
              setState(() {
                currentIndex = currentIndex.ceil().toDouble();
                updateCurrentIndex(currentIndex);
              });
            },
            child: OverlappedCarouselCardItems(
              cards: List.generate(
                widgets.length,
                    (index) => CardModel(
                  id: index,
                  child: widgets[index],
                ),
              ),
              centerIndex: currentIndex,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
              onClicked: widget.onClicked,
              obscure: widget.obscure,
              skewAngle: widget.skewAngle,
            ),
          );
        },
      ),
    );
  }
}

class OverlappedCarouselCardItems extends StatelessWidget {
  final List<CardModel> cards;
  final Function(int) onClicked;
  final double centerIndex;
  final double maxHeight;
  final double maxWidth;
  final double obscure;
  final double skewAngle;

  OverlappedCarouselCardItems({
    required this.cards,
    required this.centerIndex,
    required this.maxHeight,
    required this.maxWidth,
    required this.onClicked,
    required this.obscure,
    required this.skewAngle,
  });

  double getCardPosition(int index) {
    final double center = maxWidth / 2;
    final double centerWidgetWidth = maxWidth / 4;
    final double basePosition = center - centerWidgetWidth / 2 - 12;
    final distance = centerIndex - index;

    final double nearWidgetWidth = centerWidgetWidth / 5 * 4;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3;

    if (distance == 0) {
      return basePosition;
    } else if (distance.abs() > 0.0 && distance.abs() <= 1.0) {
      if (distance > 0) {
        return basePosition - nearWidgetWidth * distance.abs();
      } else {
        return basePosition + centerWidgetWidth * distance.abs();
      }
    } else if (distance.abs() >= 1.0 && distance.abs() <= 2.0) {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2) -
            (nearWidgetWidth - farWidgetWidth) *
                ((distance - distance.floor()));
      }
    } else {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2);
      }
    }
  }

  double getCardWidth(int index) {
    final double distance = (centerIndex - index).abs();
    final double centerWidgetWidth = maxWidth / 3;
    final double nearWidgetWidth = centerWidgetWidth / 5 * 4;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3;

    if (distance >= 0.0 && distance < 1.0) {
      return centerWidgetWidth -
          (centerWidgetWidth - nearWidgetWidth) * (distance - distance.floor());
    } else if (distance >= 1.0 && distance < 2.0) {
      return nearWidgetWidth -
          (nearWidgetWidth - farWidgetWidth) * (distance - distance.floor());
    } else {
      return farWidgetWidth;
    }
  }

  Matrix4 getTransform(int index) {
    final distance = centerIndex - index;

    var transform = Matrix4.identity()
      ..setEntry(3, 2, 0.007)
      ..rotateY(skewAngle * distance)
      ..scale(1.25, 1.25, 1.25);
    if (index == centerIndex) transform..scale(1.05, 1.05, 1.05);
    return transform;
  }

  Widget _buildItem(CardModel item) {
    final int index = item.id;
    final width = getCardWidth(index);
    final height = maxHeight - 10 * (centerIndex - index).abs();
    final position = getCardPosition(index);
    final verticalPadding = width * 0.05 * (centerIndex - index).abs();

    return Positioned(
      left: position,
      child: Transform(
        transform: getTransform(index),
        alignment: FractionalOffset.center,
        child: Stack(
          children: [
            Container(
              width: width.toDouble(),
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              height: height > 0 ? height : 0,
              child: item.child,
            ),
            Container(
              width: width.toDouble(),
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              height: height > 0 ? height : 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: getFilter(obscure, index),
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageFilter getFilter(double obscure, int index){
    final distance = (centerIndex - index).abs();
    return ImageFilter.blur(sigmaX: 5.0*obscure*distance, sigmaY: 5.0*obscure*distance);
  }

  List<Widget> _sortedStackWidgets(List<CardModel> widgets) {
    for (int i = 0; i < widgets.length; i++) {
      if (widgets[i].id == centerIndex) {
        widgets[i].zIndex = widgets.length.toDouble();
      } else if (widgets[i].id < centerIndex) {
        widgets[i].zIndex = widgets[i].id.toDouble();
      } else {
        widgets[i].zIndex =
            widgets.length.toDouble() - widgets[i].id.toDouble();
      }
    }
    widgets.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return widgets.map((e) {
      double distance = (centerIndex - e.id).abs();
      if (distance >= 0 && distance <= 3)
        return _buildItem(e);
      else
        return Container();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: _sortedStackWidgets(cards),
      ),
    );
  }
}
