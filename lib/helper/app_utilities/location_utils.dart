// import 'dart:io';
// import 'dart:math' as math show cos, sqrt, asin;
//
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart' as handler;
//
// class LocationUtils {
//   late Location location;
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//
//   LocationUtils() {
//     this.location = Location();
//     this.location.changeSettings(
//         accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 500,);
//   }
//
//   Future<LocationData?> getCurrentLocation() async {
//     final _status = await handler.Permission.location.request();
//     if (_status.isGranted) {
//       // if (await isLocationEnabled()) {
//       return await _getMeLocation();
//       // } else {
//       //   return null;
//       // }
//     } else {
//       return null;
//     }
//   }
//
//   Future<bool> isLocationEnabled() async {
//     final _status = await handler.Permission.location.request();
//     if (_status.isGranted) {
//       // CboToast.showText(text:"Ok Call Back");
//       return ((await handler
//               .Permission.locationWhenInUse.serviceStatus.isEnabled) ||
//           (await handler.Permission.locationAlways.serviceStatus.isEnabled));
//
//     } else {
//       // CboToast.showText(text:"cancel Call Back");
//       return false;
//     }
//   }
//
//   Future<LocationData?> _getMeLocation() async {
//     LocationData? locationData;
//     // _serviceEnabled = await location.serviceEnabled();
//     // if (!_serviceEnabled) {
//     //   if (Platform.isIOS) {
//     //     return null;
//     //   }
//     //
//     //   _serviceEnabled = await location.requestService();
//     //   if (!_serviceEnabled) {
//     //     return null;
//     //   }
//     // }
//     //
//     // if (Platform.isAndroid) {
//     //   final _response = await UtilsNative().requestGPS();
//     //   if (!_response.isSuccess) {
//     //     return null;
//     //   }
//     // }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }
//
//     try {
//       locationData = await location.getLocation();
//     } catch (e, s) {
//       print("exception while getting loc $e and trace: $s");
//     }
//     debugPrint("LOCATION DATA: ${locationData.toString()}");
//     return locationData;
//   }
//
//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     // var p = 0.017453292519943295;
//     // var c = cos;
//     // var a = 0.5 -
//     //     c((lat2 - lat1) * p) / 2 +
//     //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     // return 12742 * asin(sqrt(a));
//
//     var p = 0.017453292519943295;
//     var c = math.cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     double _dist = 12742 * math.asin(math.sqrt(a));
//     return _dist;
//   }
//
//   Future<LocExtraHolder> getCurrentLocationData() async {
//     final _locUtils = LocationUtils();
//     LocationData? _currLocation = await _locUtils.getCurrentLocation();
//     if (_currLocation == null) {
//       return LocExtraHolder("0.0,0.0", "");
//     }
//     final _latLongAPi = "${_currLocation.latitude},${_currLocation.longitude}";
//     final _locExtra =
//         "Lat_Long ${_currLocation.latitude},${_currLocation.longitude},Accuracy ${_currLocation.accuracy},Time ${_currLocation.time},Speed ${_currLocation.speed}";
//     return LocExtraHolder(_latLongAPi, _locExtra);
//   }
//
// }
//
// class LocExtraHolder {
//   String latLong;
//   String locExtra;
//
//   LocExtraHolder(this.latLong, this.locExtra);
// }
