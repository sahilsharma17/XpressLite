import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xpresslite/model/replyModel.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../repo/reply_repo.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  ReplyCubit() : super(ReplyInitial());

  ReplyCommentRepo replyRepo =
  ReplyCommentRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<ReplyCommentModel>> comReplies;
  late ApiResponse reply;

  Future<void> getReplies(int newsComId) async {
    try {
      emit(ReplyLoading());
      if (await MethodUtils.isInternetPresent()) {
        comReplies = await replyRepo.getReplies(nComId : newsComId);
        if (comReplies.isSuccess) {
          emit(ReplyLoaded(
            msg: "Got data",
            replies : comReplies.resObject ?? [],
          ));
        } else {
          emit(ReplyError(error: comReplies.errorCause));
        }
      } else {
        emit(ReplyError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(ReplyError(error: e.toString()));
    }
  }

  Future<void> postReply({required int newsComId,required String comReply}) async {
    reply = await replyRepo.postReply(nComId : newsComId, reply: comReply );

    try {
      emit(ReplyLoading());
      if (await MethodUtils.isInternetPresent()) {
        if (reply.isSuccess) {
          getReplies(newsComId);
        } else {
          emit(ReplyError(error: reply.errorCause));
        }
      } else {
        emit(ReplyError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(ReplyError(error: e.toString()));
    }
  }



  void refresh() {
    emit(ReplyInitial());
  }
}
