// import 'dart:ui';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../../model/searchModel.dart';
//
// class CustomCard3 extends StatefulWidget {
//   List<SearchModel>? searchedNews;
//
//   CustomCard3({super.key, required this.searchedNews});
//
//   @override
//   State<CustomCard3> createState() => _CustomCard3State();
// }
//
// class _CustomCard3State extends State<CustomCard3> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       color: Colors.white,
//       // padding: EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: (size.height / 5) - 28,
//             width: (size.width / 2) - 12,
//             decoration: const BoxDecoration(color: Colors.white),
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: ClipRRect(
//                       child: ImageFiltered(
//                         imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: CachedNetworkImage(
//                           imageUrl: widget
//                               .searchedNews![index].imageFileNames![0]
//                               .toString(),
//                           imageBuilder: (context, imageProvider) => Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: imageProvider, fit: BoxFit.cover),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: CachedNetworkImage(
//                     imageUrl: widget.searchedNews![index].imageFileNames![0]
//                         .toString(),
//                     imageBuilder: (context, imageProvider) => Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: imageProvider, fit: BoxFit.contain),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Time',
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Spacer(),
//                     Icon(
//                       Icons.favorite_border_outlined,
//                       color: Colors.orange,
//                       size: 20,
//                     )
//                   ],
//                 ),
//                 Text(
//                   widget.searchedNews![index].title.toString(),
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
