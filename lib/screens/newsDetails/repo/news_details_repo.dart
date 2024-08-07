import 'package:flutter/cupertino.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';
import 'package:xpresslite/helper/constant/apiUrls.dart';
import 'package:xpresslite/model/newsCommentsModel.dart';
import 'package:xpresslite/model/newsDetailsByIdModel.dart';
import 'package:xpresslite/model/newsFeaturesModel.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';

import '../../../helper/app_utilities/date_utils.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/reposeCallBack.dart';

abstract class NewsDetailScreenRepoAbstract {
  Future<ApiResponse<NewsDetailsByIdModel>> getNewsDetailsById(
      {required int newsId});

  Future<ApiResponse<List<NewsCommentsModel>>> getNewsComments(
      {required int newsId});

  Future<ApiResponse<NewsFeaturesModel>> getNewsFeatures(
      {required int newsId});

  Future<ApiResponse<List<PaginatedNewsModel>>> getRelatedNews(
      {required String newsCatId});

  Future<ApiResponse> newsFav(int newsId, bool favValue);

  Future<ApiResponse> postReply({required int comId, required String reply});
}

class NewsDetailScreenRepo implements NewsDetailScreenRepoAbstract {
  NetworkRequest networkRequest;

  NewsDetailScreenRepo({required this.networkRequest});

  @override
  Future<ApiResponse<NewsDetailsByIdModel>> getNewsDetailsById(
      {required int newsId}) async {
    Map<String, dynamic> newsIdMap = {"NewsDetailsId": newsId};

    debugPrint("News Id Data Param is $newsIdMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.idWiseNewsDetails, newsIdMap);
    debugPrint(resp.toString());

    NewsDetailsByIdModel? _newsDetailsbyId;

    if (resp["status"] == true) {
      Map<String, dynamic> data = resp['data'];
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
  Future<ApiResponse<NewsFeaturesModel>> getNewsFeatures(
      {required int newsId}) async {
    Map<String, dynamic> newsIdMap = {
      "NewsDetailsId": newsId,
      "createdBy": await PreferenceHandler.getEmpId(),
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString()
    };

    debugPrint("News Id Data Param is $newsIdMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.getNewsFeatures, newsIdMap);
    debugPrint(resp.toString());

    NewsFeaturesModel? _newsFeatures;

    if (resp["status"] == true) {
      Map<String, dynamic> data = resp['data'];
      if (data != null) {
        _newsFeatures = NewsFeaturesModel.fromJson(data);
      }
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _newsFeatures,
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
      {required int newsId}) async {
    Map<String, dynamic> newsIdMap = {
      "NewsDetailsId": newsId,
      "createdBy": await PreferenceHandler.getEmpId(),
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
      } else {}

      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: _newsComments,
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: _newsComments,
      );
    }
  }

  @override
  Future<ApiResponse<List<PaginatedNewsModel>>> getRelatedNews(
      {required String newsCatId}) async {
    Map<String, dynamic> pRelatedMap = {
      "pageNumber": 1,
      "pageSize": 6,
      "categoryId": newsCatId,
      "createdBy": await PreferenceHandler.getEmpId(),
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.getNewsPaginated, pRelatedMap);

    List<PaginatedNewsModel>? _pRelatedNews;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'];
      if (data != null) {
        _pRelatedNews = List.generate(
            data.length, (index) => PaginatedNewsModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _pRelatedNews);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List>> postComment(
      {required int newsId, required String comment}) async {
    Map<String, dynamic> commentMap = {
      "NewsDetailsId": newsId,
      "createdBy": await PreferenceHandler.getEmpId(),
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString(),
      "comment": comment
    };
    debugPrint("Comment Data Param is $commentMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.postComment, commentMap);
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: resp['data'],
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List>> delComment(
      {required int nComId, required String nComReplyId}) async {
    Map<String, dynamic> delcommentMap;
    if (nComReplyId == '') {
      delcommentMap = {
        "NewsCommentsId": nComId,
      };
    } else {
      delcommentMap = {
        "CommentsReplyId": nComReplyId,
      };
    }

    debugPrint("Comment Data Param is $delcommentMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.delComment, delcommentMap);
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: resp['data'],
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List>> delReply(
      {required String nComReplyId}) async {
    Map<String, dynamic> delReplyMap = {
      "CommentsReplyId": nComReplyId,
    };

    debugPrint("Comment Data Param is $delReplyMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.delComment, delReplyMap);
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: resp['data'],
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List>> updateComment(
      {required int nComId, required String newComment}) async {
    Map<String, dynamic> delcommentMap = {
      "NewsCommentsId": nComId,
      "Comment": newComment
    };

    debugPrint("Comment Data Param is $delcommentMap");

    final resp = await networkRequest.networkCallPostMap2(
        ApiUrls.updateComment, delcommentMap);
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      return ApiResponse(
        isSuccess: resp["status"],
        errorCause: resp["message"],
        resObject: resp['data'],
      );
    } else {
      return ApiResponse(
        isSuccess: true,
        errorCause: resp["message"],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse> newsFav(int newsId, bool favValue) async {
    Map<String, dynamic> favNewsMap = {
      "newsDetailsId": newsId,
      "createdBy": await PreferenceHandler.getEmpId(),
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString(),
      "IP": "",
      "isFavourite": favValue,
    };

    Map<String, dynamic> resp =
        await networkRequest.networkCallPostMap2(ApiUrls.createFav, favNewsMap);

    // ApiResponse? _newsFav;
    debugPrint(resp.toString());

    if (resp["status"] == true) {
      // List<dynamic> data = resp['data'];
      // if (data != null) {
      //   _newsFav = List.generate(data.length,
      //           (index) => ApiResponse.fromJson(data[index]));
      // }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: 'updated');
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse> postReply(
      {required int comId, required String reply}) async {
    Map<String, dynamic> replyMap = {
      "NewsCommentsId": comId,
      "createdBy": await PreferenceHandler.getEmpId(),
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString(),
      "isFavourite": reply,
    };

    Map<String, dynamic> resp =
        await networkRequest.networkCallPostMap2(ApiUrls.reply, replyMap);

    debugPrint(resp.toString());

    if (resp["status"] == true) {
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: 'replied');
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse> postRating(
      {required int newsId, required int rate}) async {
    Map<String, dynamic> rateMap = {
      "newsDetailsId": newsId,
      "createdBy": await PreferenceHandler.getEmpId(),
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString(),
      "Rating": rate,
    };

    Map<String, dynamic> resp =
    await networkRequest.networkCallPostMap2(ApiUrls.postRating, rateMap);

    debugPrint(resp.toString());

    if (resp["status"] == true) {
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: 'rated');
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }
}
