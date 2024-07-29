import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../model/AllRatersModel.dart';
import '../../../model/reposeCallBack.dart';

abstract class AllRatingsRepoAbstract {
  Future<ApiResponse<List<AllRatingModel>>> allRaters({required int newsId});
}

class AllRatingsRepo implements AllRatingsRepoAbstract {
  NetworkRequest networkRequest;

  AllRatingsRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<AllRatingModel>>> allRaters(
      {required int newsId}) async {
    Map<String, dynamic> newsRatingMap = {'newsDetailsId': newsId};

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.allRating, newsRatingMap);

    List<AllRatingModel>? _allRaters;
    debugPrint(resp.toString());

    if (resp['status'] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _allRaters = List.generate(
            data.length, (index) => AllRatingModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _allRaters);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
      );
    }
  }
}
