import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/newsCommentsModel.dart';
import 'package:xpresslite/model/newsDetailsByIdModel.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../model/reposeCallBack.dart';

abstract class NewsDetailScreenRepoAbstract {
  Future<ApiResponse<NewsDetailsByIdModel>> getNewsDetailsById(
      {required String newsId});

  Future<ApiResponse<List<NewsCommentsModel>>> getNewsComments(
      {required String newsId});
}

class NewsDetailScreenRepo implements NewsDetailScreenRepoAbstract {
  NetworkRequest networkRequest;

  NewsDetailScreenRepo({required this.networkRequest});

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
      Map<String, dynamic> data = resp['data'] ;
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

  @override
  Future<ApiResponse<List<NewsCommentsModel>>> getNewsComments(
      {required String newsId}) async {
    Map<String, String> newsIdMap = {
      "NewsDetailsId": newsId,
      "createdBy": "00500877"
    };

    debugPrint("News Id Data Param is $newsIdMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.getNewsCommentDetails, newsIdMap);
    debugPrint(resp.toString());

    List<NewsCommentsModel>? _newsComments = [];

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _newsComments = List.generate(
            data.length, (index) => NewsCommentsModel.fromJson(data[index]));
      }else{

      }

      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _newsComments,
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject:  _newsComments,
      );
    }
  }
}
