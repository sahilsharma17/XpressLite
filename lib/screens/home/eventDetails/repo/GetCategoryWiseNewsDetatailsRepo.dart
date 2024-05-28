import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/categorised_news_detail_model.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

abstract class GetCategoryWiseNewsDetailsRepoAbstract {
  Future<ApiResponse<List<CategorisedNewsDetailsModel>>>
      getCategoryWiseNewsDetails();
}

class GetCategoryWiseNewsDetailsRepo
    implements GetCategoryWiseNewsDetailsRepoAbstract {
  NetworkRequest networkRequest;

  GetCategoryWiseNewsDetailsRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<CategorisedNewsDetailsModel>>>
      getCategoryWiseNewsDetails() async {
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
}
