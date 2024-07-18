import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/helper/app_utilities/size_reziser.dart';
import 'package:xpresslite/model/newsCommentsModel.dart';
import 'package:xpresslite/model/replyModel.dart';
import 'package:xpresslite/screens/reply/cubit/reply_cubit.dart';

import '../../Widget/customWidget/commentBarWidget.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/bottomsheet/bottomsheet.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';

class ReplyScreen extends StatefulWidget {
  int newsComId;
  NewsCommentsModel comment;

  ReplyScreen({required this.newsComId, required this.comment, super.key});

  @override
  State<ReplyScreen> createState() => _ReplyScreenState();
}

class _ReplyScreenState extends State<ReplyScreen> {
  late ReplyCubit _cubit;

  List<ReplyCommentModel>? replies = [];

  TextEditingController replyController = TextEditingController();

  @override
  void initState() {
    _cubit = BlocProvider.of<ReplyCubit>(context);
    _cubit.getReplies(widget.newsComId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          // leading: GestureDetector(
          //   onTap: () {
          //     Navigator.pop(context, true);
          //   },
          //   child: Image.asset('assets/chevron_left.png'),
          // ),
          title: const Text(
            'REPLIES',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: CommentBottomBar(
              controller: replyController,
              onSend: () {
                // Call the method to post the comment
                _cubit.postReply(
                    newsComId: widget.newsComId,
                    comReply: replyController.text);

                // Clear the text field after posting the comment
                replyController.clear();
              }),
        ),
        body: BlocConsumer<ReplyCubit, ReplyState>(
            builder: (BuildContext context, state) {
          if (state is ReplyLoaded) {
            print('Loaded');
            replies = state.replies ?? [];

            return commentSection();
          } else if (state is ReplyInitial) {
            return AppLoaderProgress();
          } else if (state is ReplyLoading) {
            return Stack(
              children: [AppLoaderProgress()],
            );
          } else if (state is ReplyError) {
            return commentSection();
          }
          return AccessDeniedScreen(
            onPressed: () {
              // _cubit.getRelatedNews(widget.catId);
            },
          );
        }, listener: (BuildContext context, state) {
          if (state is ReplyError) {
            if (state.error.isNotEmpty) {
              MethodUtils.toast(state.error);
            }
          } else if (state is ReplyLoaded) {}
        }));
  }

  commentSection() {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      widget.comment?.profileImage?.toString() ?? ''),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.comment?.name?.toString() ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.comment?.comment?.toString() ?? '',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'time ago',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Like',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // IconButton(
                          //   onPressed: () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       isScrollControlled: true,
                          //       builder: (BuildContext context) {
                          //         return MyBottomSheet(
                          //           oldComment:
                          //           widget.comment![i].comment.toString(),
                          //           cubit: _cubit,
                          //           commentId:
                          //           widget.comment?[i].commentId ?? 0,
                          //           categoryId: widget.catId,
                          //           newsId: widget.newsId,
                          //         );
                          //       },
                          //     );
                          //   },
                          //   icon: Icon(
                          //     Icons.edit_outlined,
                          //     size: 20,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      width: 100,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'XpressLite',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Are you Sure? You want to delete this comment.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 100,
                                                        child: Text(
                                                          'No',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // Navigator.pop(
                                                        //     context, true);
                                                        // _cubit
                                                        //     .deleteComment(
                                                        //   widget.newsId,
                                                        //   widget.catId,
                                                        //   widget.comment?[i]
                                                        //       .commentId ??
                                                        //       0,
                                                        //   '',
                                                        // );
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 100,
                                                        child: Text(
                                                          'Yes',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.orange,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: replies?.length,
              itemBuilder: (BuildContext context, int j) {
                return Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            replies?[j].profileImage?.toString() ?? ''),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              width: SizeConfig.screenWidth * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      replies?[j].name?.toString() ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      replies?[j].commentsReply?.toString() ??
                                          '',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Like',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return MyBottomSheet();
                                    //   },
                                    // );
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            width: 100,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'XpressLite',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Are you Sure? You want to delete this comment.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 100,
                                                              child: Text(
                                                                'No',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            // onTap: () {
                                                            //   Navigator.pop(context, true);
                                                            //   _cubit.deleteComment(
                                                            //     widget.newsId,
                                                            //     widget.catId,
                                                            //     replies?[i].commentId ?? 0,
                                                            //     replies![i].replies![j].commentReplyId.toString() ?? '',
                                                            //   );
                                                            // },
                                                            child: Container(
                                                              height: 30,
                                                              width: 100,
                                                              child: Text(
                                                                'Yes',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete_forever_outlined,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
