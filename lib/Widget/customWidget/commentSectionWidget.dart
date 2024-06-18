// import 'package:flutter/material.dart';
// import 'package:xpresslite/model/newsCommentsModel.dart';
//
// class CommentSectionWidget extends StatelessWidget {
//   final List<NewsCommentsModel>? comments;
//   final Function(int, int)? onEditComment;
//   final Function(int, int)? onDeleteComment;
//
//   const CommentSectionWidget({
//     Key? key,
//     this.comments,
//     this.onEditComment,
//     this.onDeleteComment,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: comments?.length,
//         itemBuilder: (context, i) {
//           return _buildCommentWidget(context, i);
//         },
//       ),
//     );
//   }
//
//   Widget _buildCommentWidget(BuildContext context, int index) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CircleAvatar(
//                 radius: 20.0,
//                 backgroundImage: NetworkImage(
//                   comments?[index].profileImage?.toString() ?? '',
//                 ),
//                 backgroundColor: Colors.transparent,
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           comments?[index].name?.toString() ?? '',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           comments?[index].comment?.toString() ?? '',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               _buildActionButtons(index),
//             ],
//           ),
//           if ((comments?[index].replies?.isNotEmpty ?? false) &&
//               comments![index].replies != null)
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: comments?[index].replies?.length ?? 0,
//               itemBuilder: (context, j) {
//                 return _buildReplyWidget(context, index, j);
//               },
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildReplyWidget(BuildContext context, int commentIndex, int replyIndex) {
//     final reply = comments?[commentIndex].replies?[replyIndex];
//     return Padding(
//       padding: EdgeInsets.only(left: 40, top: 10),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 18.0,
//             backgroundImage: NetworkImage(reply?.profileImage?.toString() ?? ''),
//             backgroundColor: Colors.transparent,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       reply?.name?.toString() ?? '',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       reply?.commentsReply?.toString() ?? '',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           GestureDetector(
//             onTap: () => onEditReply?.call(commentIndex, replyIndex, reply?.commentReplyId ?? 0),
//             child: Text(
//               'Edit',
//               style: TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//           SizedBox(width: 10),
//           IconButton(
//             onPressed: () => onDeleteReply?.call(commentIndex, replyIndex, reply?.commentReplyId ?? 0),
//             icon: Icon(Icons.delete_forever_outlined, size: 20),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildActionButtons(int index) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'time ago',
//               style: TextStyle(fontSize: 12),
//             ),
//             SizedBox(width: 20),
//             GestureDetector(
//               onTap: () => onEditComment?.call(index, comments?[index].commentId ?? 0),
//               child: Text(
//                 'Like',
//                 style: TextStyle(fontSize: 12, color: Colors.black87),
//               ),
//             ),
//             SizedBox(width: 20),
//             GestureDetector(
//               onTap: () => onEditComment?.call(index, comments?[index].commentId ?? 0),
//               child: Text(
//                 'Reply',
//                 style: TextStyle(fontSize: 12, color: Colors.black87),
//               ),
//             ),
//             SizedBox(width: 10),
//             IconButton(
//               onPressed: () => onDeleteComment?.call(index, comments?[index].commentId ?? 0),
//               icon: Icon(Icons.edit_outlined, size: 20),
//             ),
//             IconButton(
//               onPressed: () => onDeleteComment?.call(index, comments?[index].commentId ?? 0),
//               icon: Icon(Icons.delete_forever_outlined, size: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
