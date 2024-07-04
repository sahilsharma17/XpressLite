import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/reportModel.dart';

import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';

abstract class ReportScreenRepoAbstract {
  Future<ApiResponse<List<ReportModel>>> ceoReports(
      {String? month,String? date});

  Future<ApiResponse<List<ReportModel>>> otherReports(
      {String? month,String? date});
}

class ReportsRepo implements ReportScreenRepoAbstract {
  NetworkRequest networkRequest;

  ReportsRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<ReportModel>>> ceoReports(
      {String? month,String? date}) async {
    Map<String, dynamic> reportMap = {
      "month": month,
      "createdDate": date,
      "notificationType": "ChairmanDirectorPdf"
    };

    debugPrint("Param is $reportMap");

    final resp =
        await networkRequest.networkCallPostMap2(ApiUrls.ceoReports, reportMap);
    debugPrint(resp.toString());

    List<ReportModel>? _reports;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _reports = List.generate(
            data.length, (index) => ReportModel.fromJson(data[index]));
      } else {}

      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _reports,
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: _reports,
      );
    }
  }

  @override
  Future<ApiResponse<List<ReportModel>>> otherReports(
      {String? month,String? date}) async {
    Map<String, dynamic> reportMap = {
      "month": month,
      "createdDate": date,
      "notificationType": "BulletinPdf"
    };

    debugPrint("Param is $reportMap");

    final resp =
        await networkRequest.networkCallPostMap2(ApiUrls.otherReports, reportMap);
    debugPrint(resp.toString());

    List<ReportModel>? _reports;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _reports = List.generate(
            data.length, (index) => ReportModel.fromJson(data[index]));
      } else {}

      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _reports,
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: _reports,
      );
    }
  }
}
