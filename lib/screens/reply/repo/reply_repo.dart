import 'package:flutter/material.dart';
import '../../../../helper/constant/apiUrls.dart';
import '../../../../model/reposeCallBack.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../helper/app_utilities/date_utils.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../../../model/replyModel.dart';

abstract class ReplyCommentRepoAbstract {
  Future<ApiResponse<List<ReplyCommentModel>>> getReplies(
      {required int nComId});

  Future<ApiResponse<List>> postReply(
      {required int nComId, required String reply});
}

class ReplyCommentRepo implements ReplyCommentRepoAbstract {
  NetworkRequest networkRequest;

  ReplyCommentRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<ReplyCommentModel>>> getReplies(
      {required int nComId}) async {
    Map<String, dynamic> replyMap = {
      "createdBy": await PreferenceHandler.getEmpId(),
      "NewsCommentsId": nComId
    };

    Map<String, dynamic> resp = await networkRequest.networkCallPostMap2(
        ApiUrls.repliesOnComment, replyMap);

    debugPrint(resp.toString());

    List<ReplyCommentModel>? _replyModel;

    if (resp["status"] == true) {
      List<dynamic> data = resp['data'] as List<dynamic>;
      if (data != null) {
        _replyModel = List.generate(
            data.length, (index) => ReplyCommentModel.fromJson(data[index]));
      }
      return ApiResponse(
          isSuccess: resp['status'],
          errorCause: resp['message'],
          resObject: _replyModel);
    } else {
      return ApiResponse(
        isSuccess: resp['status'],
        errorCause: resp['message'],
        resObject: null,
      );
    }
  }

  @override
  Future<ApiResponse<List>> postReply(
      {required int nComId, required String reply}) async {
    Map<String, dynamic> postReplyMap = {
      "createdDate": AppDateUtils.getFormattedDateWithTime().toString(),
      "createdBy": await PreferenceHandler.getEmpId(),
      "NewsCommentsId": nComId,
      "CommentReply": reply
    };

    debugPrint("Comment Data Param is $postReplyMap");

    final resp =
        await networkRequest.networkCallPostMap2(ApiUrls.reply, postReplyMap);
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
}
