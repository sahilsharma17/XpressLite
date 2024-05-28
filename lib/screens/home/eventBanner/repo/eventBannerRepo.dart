import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/UpcomingEventBannerModel.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

abstract class EventBannerRepoAbstract {
  Future<ApiResponse<EventBannerModel>> getEventBanner();
}

class EventBannerRepo implements EventBannerRepoAbstract {
  NetworkRequest networkRequest;

  EventBannerRepo({required this.networkRequest});

  @override
  Future<ApiResponse<EventBannerModel>> getEventBanner() async {
    Map<String, dynamic> resp =
        await networkRequest.networkCallGetMap(ApiUrls.upcomingEvent);

    EventBannerModel? _eventsModel;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _eventsModel = EventBannerModel.fromJson(resp);
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
