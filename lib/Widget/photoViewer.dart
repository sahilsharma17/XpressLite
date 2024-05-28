import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

import '../../helper/dxWidget/dx_text.dart';

class PhotoViewer extends StatelessWidget {
  String images;
  PhotoViewer({Key? key , required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title:  DxTextWhite("View Image", mBold: true, mSize: 20),
        ),
        body:PhotoView(
          backgroundDecoration: const BoxDecoration(
              color: Colors.white
          ),
          imageProvider: NetworkImage(images),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
        )
    );
  }
}
