import 'package:flutter/material.dart';

import '../../../helper/app_utilities/date_utils.dart';
import '../../../helper/constant/apiUrls.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../../newsDetails/repo/news_details_repo.dart';

abstract class FavsNewsScreenRepoAbstract {
  Future<ApiResponse<List<PaginatedNewsModel>>> getFavNews();
}

class FavsNewsScreenRepo implements FavsNewsScreenRepoAbstract {
  NetworkRequest networkRequest;

  FavsNewsScreenRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<PaginatedNewsModel>>> getFavNews() async {

    Map<String, dynamic> resp = await networkRequest.networkCallGetMap(
        ApiUrls.favs);

    List<PaginatedNewsModel>? _pFavsNews;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _pFavsNews = List.generate(
            data.length, (index) => PaginatedNewsModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _pFavsNews);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse> newsFav(int newsId, bool favValue) async {
    Map<String, dynamic> favNewsMap = {

      "newsDetailsId": newsId,
      "createdBy": await PreferenceHandler.getEmpId(),
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString(),
      "IP": "",
      "isFavourite": favValue,
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.createFav, favNewsMap);

    // ApiResponse? _newsFav;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      // List<dynamic> data = resp['data'];
      // if (data != null) {
      //   _newsFav = List.generate(data.length,
      //           (index) => ApiResponse.fromJson(data[index]));
      // }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: 'updated');
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

}