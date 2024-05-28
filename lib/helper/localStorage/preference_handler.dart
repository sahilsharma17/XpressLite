
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpresslite/helper/localStorage/prefKeys.dart';
import 'AppPrefrences.dart';

class PreferenceHandler {
  PreferenceHandler._();

  static Future<void> setLoginToken(String companyCode) async {
    await AppPrefrence.setString(PrefKeys.token, companyCode);
  }

  static Future<String?> getLoginToken() async {
    return await AppPrefrence.getString(PrefKeys.token);
  }

  //============================================//

  static Future<void> setUserId(String userId) async {
    await AppPrefrence.setString(PrefKeys.userId, userId);
  }

  static Future<String?> getUserId() async {
    return AppPrefrence.getString(PrefKeys.userId);
  }

  //============================================//
  static Future<void> setMoodId(String userId) async {
    await AppPrefrence.setString(PrefKeys.moodId, userId);
  }

  static Future<String?> getMoodId() async {
    return AppPrefrence.getString(PrefKeys.moodId);
  }

  //============================================//
  static Future<void> setOrganId(String userId) async {
    await AppPrefrence.setString(PrefKeys.organId, userId);
  }

  static Future<String?> getOrganId() async {
    return AppPrefrence.getString(PrefKeys.organId);
  }

  //===================version========//
  static Future<void> setAndroidVersion(String version) async {
    await AppPrefrence.setString(PrefKeys.androidVersion, version);
  }

  static Future<String?> getAndroidVersion() async {
    return await AppPrefrence.getString(PrefKeys.androidVersion);
  }

  static Future<void> setIosVersion(String version) async {
    await AppPrefrence.setString(PrefKeys.iosVersion, version);
  }

  static Future<String?> getIosVersion() async {
    return await AppPrefrence.getString(PrefKeys.iosVersion);
  }

  //============================================//
  static Future<void> setProblemId(String userId) async {
    await AppPrefrence.setString(PrefKeys.problemId, userId);
  }

  static Future<String?> getProblemId() async {
    return AppPrefrence.getString(PrefKeys.problemId);
  }

  //============================================//
  static Future<void> setProductId(String userId) async {
    await AppPrefrence.setString(PrefKeys.productId, userId);
  }

  static Future<String?> getProductId() async {
    return AppPrefrence.getString(PrefKeys.productId);
  }
  //============================================//
  static Future<void> setNewUserId(String userId) async {
    await AppPrefrence.setString(PrefKeys.newUSerId, userId);
  }

  static Future<String?> getNewUsertId() async {
    return AppPrefrence.getString(PrefKeys.newUSerId);
  }

  static Future<void> setDeviceLat(String latLong) async {
    await AppPrefrence.setString(PrefKeys.deviceLat, latLong);
  }

  static Future<String?> getDeviceLat() async {
    return AppPrefrence.getString(PrefKeys.deviceLat);
  }

  static Future<void> setDeviceLong(String latLong) async {
    await AppPrefrence.setString(PrefKeys.deviceLong, latLong);
  }

  static Future<String?> getDeviceLong() async {
    return AppPrefrence.getString(PrefKeys.deviceLong);
  }

  static Future<void> setCompanyLat(String latLong) async {
    await AppPrefrence.setString(PrefKeys.companyLat, latLong);
  }

  static Future<String?> getCompanyLat() async {
    return AppPrefrence.getString(PrefKeys.companyLat);
  }

  static Future<void> setCompanyLong(String latLong) async {
    await AppPrefrence.setString(PrefKeys.companyLong, latLong);
  }

  static Future<String?> getCompanyLong() async {
    return AppPrefrence.getString(PrefKeys.companyLong);
  }



  static Future<void> setDoctorName(String doctor) async {
    await AppPrefrence.setString(PrefKeys.doctor, doctor);
  }

  static Future<String?> getDoctorName() async {
    return AppPrefrence.getString(PrefKeys.doctor);
  }

  static Future<void> setSps(String sps) async {
    await AppPrefrence.setString(PrefKeys.specility, sps);
  }

  static Future<String?> getSps() async {
    return AppPrefrence.getString(PrefKeys.specility);
  }

  //============================================//

  static Future<void> setEmpId(String userId) async {
    await AppPrefrence.setString(PrefKeys.userName, userId);
  }

  static Future<String?> getEmpId() async {
    return AppPrefrence.getString(PrefKeys.userName);
  }

  //=====================================================
  static Future<void> setPincode(String langId) async {
    await AppPrefrence.setString(PrefKeys.pincode, langId);
  }

  static Future<String?> getPincode() async {
    return AppPrefrence.getString(PrefKeys.pincode);
  }
  //=====================================================
  static Future<void> setContactPersonName(String langId) async {
    await AppPrefrence.setString(PrefKeys.contactPerson, langId);
  }

  static Future<String?> getContactPersonName() async {
    return AppPrefrence.getString(PrefKeys.contactPerson);
  }
  //=====================================================
  static Future<void> setContactNumber(String langId) async {
    await AppPrefrence.setString(PrefKeys.contactNumber, langId);
  }

  static Future<String?> getContactNumber() async {
    return AppPrefrence.getString(PrefKeys.contactNumber);
  }
  //=====================================================
  static Future<void> setContactEmail(String langId) async {
    await AppPrefrence.setString(PrefKeys.contactEmail, langId);
  }

  static Future<String?> getContactEmail() async {
    return AppPrefrence.getString(PrefKeys.contactEmail);
  }
  //=====================================================
  // static Future<void> setLoginType(String langId) async {
  //   await AppPrefrence.setString(PrefKeys.loginType, langId);
  // }
  //
  // static Future<String?> getLoginType() async {
  //   return AppPrefrence.getString(PrefKeys.loginType);
  // }

  //=====================================================
  static Future<void> setMobile(String langId) async {
    await AppPrefrence.setString(PrefKeys.userMobile, langId);
  }

  static Future<String?> getMobile() async {
    return AppPrefrence.getString(PrefKeys.userMobile);
  }

  static Future<void> setRoleId(String langId) async {
    await AppPrefrence.setString(PrefKeys.userRoleId, langId);
  }

  static Future<String?> getRoleId() async {
    return AppPrefrence.getString(PrefKeys.userRoleId);
  }

  static Future<void> setLoginPin(String langId) async {
    await AppPrefrence.setString(PrefKeys.login_pincode, langId);
  }

  static Future<String?> getLoginPin() async {
    return AppPrefrence.getString(PrefKeys.login_pincode);
  }


  static Future<void> setCompanyCode(String companyCode) async {
    await AppPrefrence.setString(PrefKeys.companyCode, companyCode);
  }

  static Future<String?> getCompanyCode() async {
    return AppPrefrence.getString(PrefKeys.companyCode);
  }

  static Future<void> setCompanyName(String companyName) async {
    await AppPrefrence.setString(PrefKeys.companyName, companyName);
  }

  static Future<String?> getCompanyName() async {
    return AppPrefrence.getString(PrefKeys.companyName);
  }

  static Future<void> setEmployeeCode(String empCode) async {
    await AppPrefrence.setString(PrefKeys.empCode, empCode);
  }

  static Future<String?> getEmployeeCode() async {
    return AppPrefrence.getString(PrefKeys.empCode);
  }


  //=====================================================
  static Future<void> setAddress(String langId) async {
    await AppPrefrence.setString(PrefKeys.userAddress, langId);
  }

  static Future<String?> getAddress() async {
    return AppPrefrence.getString(PrefKeys.userAddress);
  }
  //=====================================================
  static Future<void> setState(String langId) async {
    await AppPrefrence.setString(PrefKeys.userCity, langId);
  }

  static Future<String?> getState() async {
    return AppPrefrence.getString(PrefKeys.userCity);
  }  //=====================================================
  static Future<void> setRadius(String langId) async {
    await AppPrefrence.setString(PrefKeys.radius, langId);
  }

  static Future<String?> getRadius() async {
    return AppPrefrence.getString(PrefKeys.radius);
  }

  //=====================================================
  static Future<void> setAdharCard(String langId) async {
    await AppPrefrence.setString(PrefKeys.userAdharCard, langId);
  }

  static Future<String?> getAdharCard() async {
    return AppPrefrence.getString(PrefKeys.userAdharCard);
  }
  //=====================================================
  static Future<void> setUserImage(String langId) async {
    await AppPrefrence.setString(PrefKeys.userImg, langId);
  }

  static Future<String?> getUserImage() async {
    return AppPrefrence.getString(PrefKeys.userImg);
  }

  //=====================================================
  static Future<void> setName(String langId) async {
    await AppPrefrence.setString(PrefKeys.name, langId);
  }

  static Future<String?> getName() async {
    return AppPrefrence.getString(PrefKeys.name);
  }

  //=====================================================
  static Future<void> setSelectedOutletId(String langId) async {
    await AppPrefrence.setString(PrefKeys.outletId, langId);
  }

  static Future<String?> getSelectedOutletId() async {
    return AppPrefrence.getString(PrefKeys.outletId);
  }

  //=====================================================

  static Future<void> setPanCard(String langId) async {
    await AppPrefrence.setString(PrefKeys.userPanCard, langId);
  }

  static Future<String?> getPanCard() async {
    return AppPrefrence.getString(PrefKeys.userPanCard);
  }

  //============================================//

  static Future<void> setEmail(String userId) async {
    await AppPrefrence.setString(PrefKeys.userEmail, userId);
  }

  static Future<String?> getEmail() async {
    return AppPrefrence.getString(PrefKeys.userEmail);
  }
  //============================================//

  static Future<void> setPassword(String userId) async {
    await AppPrefrence.setString(PrefKeys.userPassword, userId);
  }

  static Future<String?> getPassword() async {
    return AppPrefrence.getString(PrefKeys.userPassword);
  }

  //============================================//

  static Future<void> setDob(String userId) async {
    await AppPrefrence.setString(PrefKeys.dob, userId);
  }

  static Future<String?> getDob() async {
    return AppPrefrence.getString(PrefKeys.dob);
  }

//=====================================================
  static Future<void> setLogIn(bool isDownloaded) async {
    await AppPrefrence.setBoolean(PrefKeys.isDownloaded, isDownloaded);
  }

  static Future<bool> isLogIn() async {
    return AppPrefrence.getBoolean(PrefKeys.isDownloaded);
  }
//=====================================================
  static Future<void> setLoginType(int isDownloaded) async {
    await AppPrefrence.setInt(PrefKeys.loginType, isDownloaded);
  }

  static Future<int?> getLoginType() async {
    return AppPrefrence.getInt(PrefKeys.loginType);
  }

//=====================================================
  static Future<void> setOtpVerify(bool isDownloaded) async {
    await AppPrefrence.setBoolean(PrefKeys.otpVerify, isDownloaded);
  }

  static Future<bool> getOtpVerify() async {
    return AppPrefrence.getBoolean(PrefKeys.otpVerify);
  }

  //=====================================================
  static Future<void> setOrderCompleteStatus(bool isDownloaded) async {
    await AppPrefrence.setBoolean(PrefKeys.orderCompleteStatus, isDownloaded);
  }

  static Future<bool> getOrderCompleteStatus() async {
    return AppPrefrence.getBoolean(PrefKeys.orderCompleteStatus);
  }
//=====================================================
  static Future<void> setRememberMe(bool isDownloaded) async {
    await AppPrefrence.setBoolean(PrefKeys.remember, isDownloaded);
  }

  static Future<bool> getRememberMe() async {
    return AppPrefrence.getBoolean(PrefKeys.remember);
  }



  static Future<void> setClockStart(String clockValue) async {
    await AppPrefrence.setString(PrefKeys.clockStart, clockValue);
  }

  static Future<String?> getClockStart() async {
    return AppPrefrence.getString(PrefKeys.clockStart);
  }

  //=====================================================

  static void logout(BuildContext context){
    setLogIn(false);
    // openScreenAsPlatformWiseRoute(const LoginScreen(),isExit: true);
  }

  static void clearPref() {
    AppPrefrence.clearPrefrence();
  }
}
