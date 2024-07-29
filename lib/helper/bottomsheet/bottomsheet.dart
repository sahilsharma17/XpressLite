import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xpresslite/helper/app_utilities/size_reziser.dart';
import 'package:xpresslite/helper/dxWidget/dx_text.dart';
import 'package:xpresslite/model/newsDetailsByIdModel.dart';

import '../../screens/newsDetails/cubit/news_detail_cubit.dart';

class UpdateCommentBottomSheet extends StatefulWidget {
  String oldComment, categoryId;

  NewsDetailScreenCubit cubit;
  int commentId,newsId;

  UpdateCommentBottomSheet(
      {required this.oldComment,
      required this.cubit,
      required this.commentId,
      required this.categoryId,
      required this.newsId,
      super.key});

  @override
  State<UpdateCommentBottomSheet> createState() =>
      _UpdateCommentBottomSheetState();
}

class _UpdateCommentBottomSheetState extends State<UpdateCommentBottomSheet> {
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    commentController.text = widget.oldComment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Colors.white,
        width: screenWidth,
        height: screenHeight * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Edit Comment",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: commentController,
                      cursorColor: Colors.orange,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          return Colors.orange;
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.cubit.updateComment(
                            widget.newsId,
                            widget.categoryId,
                            widget.commentId,
                            commentController.text);
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          return Colors.grey.shade700;
                        }),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadBottomSheet extends StatelessWidget {
  NewsDetailsByIdModel? newsModel;
  final VoidCallback onDownloadImage;
  final VoidCallback onDownloadPDF;

  // final VoidCallback onCancel;

  DownloadBottomSheet({
    Key? key,
    this.newsModel,
    required this.onDownloadImage,
    required this.onDownloadPDF,
    // required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              onDownloadImage();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(child: Text('Download as Image')),
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              onDownloadPDF();
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(child: Text('Download as PDF')),
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // onCancel();
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(
                  child: DxTextBlack(
                'Cancel',
                mBold: true,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePreviewBottomSheet extends StatelessWidget {
  final Uint8List image;
  final VoidCallback onSaveImage;
  final VoidCallback onCancel;

  const ImagePreviewBottomSheet({
    Key? key,
    required this.image,
    required this.onSaveImage,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.memory(image, height: 200, fit: BoxFit.cover),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onCancel,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Center(
                      child: DxTextBlack(
                    'Cancel',
                    mBold: true,
                  )),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: onSaveImage,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Center(
                      child: DxTextWhite(
                    'Save as Image',
                    mBold: true,
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RatingBottomSheet extends StatelessWidget {
  final int newsId;
  final String catId;
  final NewsDetailScreenCubit? cubit;

  RatingBottomSheet({
    Key? key,
    required this.cubit,
    required this.newsId,
    required this.catId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rating = 0;

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return Wrap(
                spacing: 0,
                children: List.generate(5, (index) {
                  final isGolden = index < rating;
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: isGolden ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                  );
                }),
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  cubit?.postRating(newsId, catId, rating);
                  Navigator.pop(context, rating);
                },
                child: Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Just close the bottom sheet
                },
                child: Text('View People'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

