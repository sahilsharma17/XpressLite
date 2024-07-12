import 'package:flutter/material.dart';

import '../../../helper/constant/apiUrls.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../../newsDetails/repo/news_details_repo.dart';

abstract class CatNewsScreenRepoAbstract {
  Future<ApiResponse<List<PaginatedNewsModel>>> getCatNews(
      {required String newsCatId});
}

class CatNewsScreenRepo implements CatNewsScreenRepoAbstract {
  NetworkRequest networkRequest;

  CatNewsScreenRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<PaginatedNewsModel>>> getCatNews({required String newsCatId}) async {
    Map<String, dynamic> pCatNewsMap = {
      "pageNumber": 1,
      "pageSize": 10,
      "categoryId": newsCatId,
      "createdBy": "00500877"
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.getNewsPaginated, pCatNewsMap);

    List<PaginatedNewsModel>? _pCatNews;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _pCatNews = List.generate(
            data.length, (index) => PaginatedNewsModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _pCatNews);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

}