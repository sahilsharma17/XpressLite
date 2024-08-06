import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';
import 'package:xpresslite/helper/constant/appMessages.dart';
import 'package:xpresslite/helper/localStorage/preference_handler.dart';
import 'package:xpresslite/model/login_model.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/auth/cubit/login_state.dart';
import 'package:xpresslite/screens/auth/repo/loginRepo.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitial());

  UserRepo loginRepo = UserRepo(networkRequest: NetworkRequest());
  late ApiResponse<LoginModel> userDetails;

  mobileValidation(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      emit(LoginError(error: AppMessages.mobile));
    } else if (mobileNumber.length != 10) {
      emit(LoginError(error: AppMessages.validMobile));
    } else {
      sendOtp(mobileNumber);
    }
  }
  
  void sendOtp(String mobileNumber) async{
    try {
      emit(LoginLoading());
      if (await MethodUtils.isInternetPresent()) {
        final response = await loginRepo.sendOtp(mobileNumber: mobileNumber);
        if (response.isSuccess) {
          MethodUtils.toast(response.resObject!);
          emit(LoginLoaded(
            msg: "OTPDialog",
          ));
        } else {
          emit(LoginError(
            error: response.errorCause));
        }
      } else {
        emit(LoginError(
          error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
  
  void verifyOtp(String mobileNumber, String otp) async {
    try {
      emit(LoginLoading());
      if (await MethodUtils.isInternetPresent()) {
        userDetails = await loginRepo.verifyOtp(mobileNumber: mobileNumber, otp: otp);
        if (userDetails.isSuccess) {
          MethodUtils.askMultiplePermission();
          await PreferenceHandler.setUserImage(userDetails.resObject?.profileImage ?? "");
          await PreferenceHandler.setName(userDetails.resObject?.name ?? "");
          await PreferenceHandler.setEmpId(userDetails.resObject?.empId ?? "");
          await PreferenceHandler.setLogIn(true);

          emit(LoginLoaded(
            msg: userDetails.errorCause
          ));
        } else {
          emit(LoginError(error: userDetails.errorCause));
        }
      } else {
        emit(LoginError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      LoginError(error: e.toString());
    }
  }

  void refresh() {
    emit(LoginInitial());
  }
}