import 'package:flutter/material.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/login_model.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

abstract class LoginRepoAbstract {
  Future<ApiResponse<String>> sendOtp({required String mobileNumber});

  Future<ApiResponse<LoginModel>> verifyOtp(
      {required String mobileNumber, required String otp});
}

class UserRepo extends LoginRepoAbstract {
  NetworkRequest networkRequest;

  UserRepo({required this.networkRequest});

  @override
  Future<ApiResponse<String>> sendOtp({required String mobileNumber}) async {
    Map<String, String> loginMap = {"Phone": mobileNumber};

  debugPrint("login Data Param is $loginMap");
    Map<String, dynamic> response =
        await networkRequest.networkCallPostMap2(ApiUrls.login, loginMap);
      debugPrint(response.toString());

    if (response["status"] == true) {
      return ApiResponse(
        isSuccess: response["status"],
        errorCause: response["message"],
        resObject: response["message"],
      );
    } else {
      return ApiResponse(
        isSuccess: false,
        errorCause: response["message"],
        resObject: response["message"],
      );
    }
  }

  @override
  Future<ApiResponse<LoginModel>> verifyOtp({required String mobileNumber, required String otp}) async {
    
    Map<String, dynamic> loginMap = {
      "phone": mobileNumber,
      "otp": otp,
    };
    debugPrint("login Data Param is $loginMap");

    Map<String, dynamic> response = 
    await networkRequest.networkCallPostMap2(ApiUrls.VerifyOtp, loginMap);
    LoginModel? _userModel;
    if (response["status"] == true ) {
      Map<String, dynamic> data = response['data'] as Map<String, dynamic>;
      if (data != null){
        _userModel = LoginModel.fromJson(data);
      }
      return ApiResponse(
        isSuccess: response["status"], 
        errorCause: response["message"],
        resObject: _userModel,
        );
    } else {
      return ApiResponse(
        isSuccess: false,
        errorCause: response["message"],
        resObject: null,);
    }

  }
}
