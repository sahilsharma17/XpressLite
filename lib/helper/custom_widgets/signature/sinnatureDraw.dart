// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:wecgarge/helper/custom_widgets/signature/signPlugin.dart';
//
// import '../../app_utilities/app_theme.dart';
// import '../../app_utilities/size_reziser.dart';
//
// class SignaturePage extends StatefulWidget {
//   @override
//   _SignaturePageState createState() => _SignaturePageState();
// }
//
// class _SignaturePageState extends State<SignaturePage> {
//   late SignatureController controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = SignatureController(
//       penStrokeWidth: 5,
//       penColor: materialPrimaryColor,
//     );
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context)
//   {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Signature(
//             height: SizeConfig.screenHeight-52,
//             controller: controller,
//             backgroundColor: Colors.white,
//           ),
//           // Positioned(
//           //     bottom: 0,
//           //     child: buildSwapOrientation()),
//         ],
//       ),
//       bottomNavigationBar: buildButtons(context),
//     );
//   }
//
//   Widget buildSwapOrientation() {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         final newOrientation =
//         isPortrait ? Orientation.landscape : Orientation.portrait;
//
//         controller.clear();
//         setOrientation(newOrientation);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               isPortrait
//                   ? Icons.screen_lock_portrait
//                   : Icons.screen_lock_landscape,
//               size: 40,
//             ),
//             const SizedBox(width: 12),
//             Text(
//               'Tap to change signature orientation',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildButtons(BuildContext context) => Container(
//     color: Colors.black,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         buildCheck(context),
//         buildClear(),
//       ],
//     ),
//   );
//
//   Widget buildCheck(BuildContext context) => IconButton(
//     iconSize: 36,
//     icon: Icon(Icons.check, color: Colors.green),
//     onPressed: () async {
//       if (controller.isNotEmpty) {
//         final signature = await exportSignature();
//
//          Navigator.of(context).pop(signature);
//
//         controller.clear();
//       }
//     },
//   );
//
//   Widget buildClear() => IconButton(
//     iconSize: 36,
//     icon: Icon(Icons.clear, color: Colors.red),
//     onPressed: () => controller.clear(),
//   );
//
//   Future<Uint8List?> exportSignature() async {
//     final exportController = SignatureController(
//       penStrokeWidth: 2,
//       penColor: Colors.black,
//       exportBackgroundColor: Colors.white,
//       points: controller.points,
//     );
//
//     final signature = await exportController.toPngBytes();
//     exportController.dispose();
//
//     return signature;
//   }
//
//   void setOrientation(Orientation orientation) {
//     if (orientation == Orientation.landscape) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeRight,
//         DeviceOrientation.landscapeLeft,
//       ]);
//     } else {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//     }
//   }
// }