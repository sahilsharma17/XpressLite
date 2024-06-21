import 'package:flutter/material.dart';
import 'package:xpresslite/model/directorsCatModel.dart';

import '../../../../helper/constant/apiUrls.dart';
import '../../../../model/reposeCallBack.dart';
import '../../../../network_configs/networkRequest.dart';

abstract class DirCatRepoAbstract {
  Future<ApiResponse<List<DirectorCatModel>>> getDirectorCategory();
}

class DirCatRepo implements DirCatRepoAbstract {
  NetworkRequest networkRequest;

  DirCatRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<DirectorCatModel>>> getDirectorCategory() async {
    Map<String, dynamic> resp =
        await networkRequest.networkCallGetMap(ApiUrls.directorCategory);

    debugPrint(resp.toString());

    List<DirectorCatModel>? _dirCatModel;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'] as List<dynamic>;
      if (data != null) {
        _dirCatModel = List.generate(
            data.length, (index) => DirectorCatModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _dirCatModel);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }
}
