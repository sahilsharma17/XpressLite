import 'package:flutter/material.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/allPdfModel.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

abstract class AllPdfsRepoAbstract {
  Future<ApiResponse<List<AllPdfModel>>> getAllPdfs({required int directorId});
}

class AllPdfsRepo extends AllPdfsRepoAbstract {
  NetworkRequest networkRequest;

  AllPdfsRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<AllPdfModel>>> getAllPdfs(
      {required int directorId}) async {
    Map<String, dynamic> pdfsMap = {"DirectorId": directorId};
    debugPrint("login Data Param is $pdfsMap");

    Map<String, dynamic> resp =
        await networkRequest.networkCallPostMap2(ApiUrls.getPdfs, pdfsMap);
    List<AllPdfModel>? _pdfModel;
    if (resp["status"] == true) {
      List<dynamic> data = resp['data'] as List<dynamic>;
      if (data != null) {
        _pdfModel = List.generate(
            data.length, (index) => AllPdfModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _pdfModel);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }
}
