import 'package:flutter/material.dart';
import 'package:xpresslite/model/focusedCatModel.dart';

import '../../../helper/constant/apiUrls.dart';
import '../../../model/PaginatedNewsModel .dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../../newsDetails/repo/news_details_repo.dart';

abstract class FocusedCategoryScreenRepoAbstract {
  Future<ApiResponse<List<FocusedCategoryModel>>> getFocusedCategory();
}

class FocusedCategoryScreenRepo implements FocusedCategoryScreenRepoAbstract {
  NetworkRequest networkRequest;

  FocusedCategoryScreenRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<FocusedCategoryModel>>> getFocusedCategory() async {
    Map<String, dynamic> resp =
        await networkRequest.networkCallGetMap(ApiUrls.getFocusedCategory);

    List<FocusedCategoryModel>? _focusedCategory;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _focusedCategory = List.generate(
            data.length, (index) => FocusedCategoryModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _focusedCategory);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }
}
