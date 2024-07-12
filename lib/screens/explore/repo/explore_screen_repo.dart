import 'package:flutter/material.dart';

import '../../../helper/constant/apiUrls.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../model/searchModel.dart';
import '../../../network_configs/networkRequest.dart';
import '../../newsDetails/repo/news_details_repo.dart';

abstract class EcploreScreenRepoAbstract {
  Future<ApiResponse<List<SearchModel>>> searchNews(
      {required String searchText});
}

class ExploreScreenRepo implements EcploreScreenRepoAbstract {
  NetworkRequest networkRequest;

  ExploreScreenRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<SearchModel>>> searchNews({required String searchText}) async {
    Map<String, dynamic> newsMap = {
    "SearchText": searchText,
    "CreatedBy" : "00500877"
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.searchNews, newsMap);

    List<SearchModel>? _searchedNews;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _searchedNews = List.generate(
            data.length, (index) => SearchModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _searchedNews);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

}