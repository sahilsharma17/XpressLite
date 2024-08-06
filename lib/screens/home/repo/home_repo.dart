import 'package:flutter/cupertino.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../helper/app_utilities/date_utils.dart';
import '../../../helper/constant/apiUrls.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/UpcomingEventBannerModel.dart';
import '../../../model/categorised_news_detail_model.dart';
import '../../../model/reposeCallBack.dart';

abstract class HomeRepoAbstract {
  Future<ApiResponse<List<EventBannerModel>>> getEventBanner();

  Future<ApiResponse<List<NewsBannerModel>>>
      getNewsBanner();

  Future<ApiResponse<List<PaginatedNewsModel>>> getHappening();

  Future<ApiResponse<List<PaginatedNewsModel>>> getAwardRecog();

  Future<ApiResponse> newsFav(int newsId, bool favValue);
}

class HomeRepo implements HomeRepoAbstract {
  NetworkRequest networkRequest;

  HomeRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<NewsBannerModel>>>
      getNewsBanner() async {
    Map<String, dynamic> resp = await networkRequest
        .networkCallGetMap(ApiUrls.getCategoryWiseNewsDetails);

    debugPrint(resp.toString());

    List<NewsBannerModel>? _categorisedNewsDetailsModel;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'] as List<dynamic>;
      if (data != null) {
        _categorisedNewsDetailsModel = List.generate(data.length,
            (index) => NewsBannerModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _categorisedNewsDetailsModel);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List<EventBannerModel>>> getEventBanner() async {
    Map<String, dynamic> resp =
        await networkRequest.networkCallGetMap(ApiUrls.upcomingEvent);

    List<EventBannerModel>? _eventsModel;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _eventsModel = List.generate(
            data.length, (index) => EventBannerModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _eventsModel);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List<PaginatedNewsModel>>> getHappening() async {
    Map<String, dynamic> pNewsMap = {
      "pageNumber": 1,
      "pageSize": 5,
      "categoryId": 5,
      "createdBy": await PreferenceHandler.getEmpId(),
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.getNewsPaginated, pNewsMap);

    List<PaginatedNewsModel>? _pNewsBanner;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _pNewsBanner = List.generate(data.length,
            (index) => PaginatedNewsModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _pNewsBanner);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List<PaginatedNewsModel>>> getAwardRecog() async {
    Map<String, dynamic> pAwardRecogMap = {
      "pageNumber": 1,
      "pageSize": 5,
      "categoryId": 5,
      "createdBy": await PreferenceHandler.getEmpId(),
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.getNewsPaginated, pAwardRecogMap);

    List<PaginatedNewsModel>? _pAwardRecog;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _pAwardRecog = List.generate(data.length,
                (index) => PaginatedNewsModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _pAwardRecog);
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
