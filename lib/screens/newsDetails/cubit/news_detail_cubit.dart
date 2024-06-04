import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_state.dart';
import 'package:xpresslite/screens/newsDetails/repo/news_details_repo.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/newsDetailsByIdModel.dart';

class NewsDetailCubit extends Cubit<NewsDetailScreenState> {
  NewsDetailCubit() : super(DetailsScreenInitial());

  NewsDetailsRepo newsDetailsRepo =
      NewsDetailsRepo(networkRequest: NetworkRequest());

  late ApiResponse<NewsDetailsByIdModel> newsDetailById;

  Future<void> getIdWiseNewsDetails(String nId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsDetailById = await newsDetailsRepo.getNewsDetailsById(newsId: nId);
        if (newsDetailById.isSuccess) {
          // MethodUtils.toast(newsModel.resObject.toString()!);
          print("HELLO......12345.................");
          emit(NewsDetailsLoaded(
              msg: "Got data",
              newsDetailByIdModel: newsDetailById.resObject));
        } else {
          emit(DetailsScreenError(error: newsDetailById.errorCause));
        }
      } else {
        emit(DetailsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DetailsScreenError(error: e.toString()));
    }
  }

  void refresh() {
    emit(DetailsScreenInitial());
  }

}
