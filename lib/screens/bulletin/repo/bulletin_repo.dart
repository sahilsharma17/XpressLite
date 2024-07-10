import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/reportModel.dart';

import '../../../model/BulletinPdfModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';

abstract class BulletinScreenRepoAbstract {

  Future<ApiResponse<List<BulletinPdfModel>>> getBulletinPdf(
      {required String month,required String date});

}

class BulletinsRepo implements BulletinScreenRepoAbstract {
  NetworkRequest networkRequest;

  BulletinsRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<BulletinPdfModel>>> getBulletinPdf(
      {required String month, required String date}) async {
    Map<String, dynamic> reportMap = {
      "month": month,
      "createdDate": date,
    };

    debugPrint("Param is $reportMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.bulletinPdf, reportMap);
    debugPrint(resp.toString());

    List<BulletinPdfModel>? _bulletin;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _bulletin = List.generate(
            data.length, (index) => BulletinPdfModel.fromJson(data[index]));
      } else {}

      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _bulletin,
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: _bulletin,
      );
    }
  }
}
