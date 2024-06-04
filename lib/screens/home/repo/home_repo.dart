

import 'package:flutter/cupertino.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../helper/constant/apiUrls.dart';
import '../../../model/UpcomingEventBannerModel.dart';
import '../../../model/categorised_news_detail_model.dart';
import '../../../model/reposeCallBack.dart';

abstract class HomeRepoAbstract {

  Future<ApiResponse<List<EventBannerModel>>> getEventBanner();

  Future<ApiResponse<List<CategorisedNewsDetailsModel>>>
  getCategoryWiseNewsDetails();
}

class HomeRepo implements HomeRepoAbstract {
  NetworkRequest networkRequest;

  HomeRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<CategorisedNewsDetailsModel>>> getCategoryWiseNewsDetails() async {
    Map<String, dynamic> resp = await networkRequest
        .networkCallGetMap(ApiUrls.getCategoryWiseNewsDetails);

    debugPrint(resp.toString());

    List<CategorisedNewsDetailsModel>? _categorisedNewsDetailsModel;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'] as List<dynamic>;
      if (data != null) {
        _categorisedNewsDetailsModel = List.generate(data.length,
                (index) => CategorisedNewsDetailsModel.fromJson(data[index]));
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
        _eventsModel = List.generate(data.length,
                (index) => EventBannerModel.fromJson(data[index]));
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



}