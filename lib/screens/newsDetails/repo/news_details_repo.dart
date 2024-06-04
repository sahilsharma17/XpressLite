import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/newsDetailsByIdModel.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../model/reposeCallBack.dart';

abstract class NewsDetailsRepoAbstract {
  Future<ApiResponse<NewsDetailsByIdModel>> getNewsDetailsById(
      {required String newsId});
}

class NewsDetailsRepo implements NewsDetailsRepoAbstract {
  NetworkRequest networkRequest;

  NewsDetailsRepo({required this.networkRequest});

  @override
  Future<ApiResponse<NewsDetailsByIdModel>> getNewsDetailsById(
      {required String newsId}) async {
    Map<String, String> newsIdMap = {"NewsDetailsId": newsId};

    debugPrint("News Id Data Param is $newsIdMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.idWiseNewsDetails, newsIdMap);
    debugPrint(resp.toString());

    NewsDetailsByIdModel? _newsDetailsbyId;

    if (resp["status"] == true) {
      Map<String, dynamic> data = resp['data'] as Map<String, dynamic>;
      if (data != null) {
        _newsDetailsbyId = NewsDetailsByIdModel.fromJson(data);
      }
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _newsDetailsbyId,
      );
    } else {
      return ApiResponse(
        isSuccess: false,
        errorCause: resp["message"],
        resObject: resp["message"],
      );
    }
  }
}
