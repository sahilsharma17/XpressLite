import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/newsCommentsModel.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_state.dart';
import 'package:xpresslite/screens/newsDetails/repo/news_details_repo.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/newsDetailsByIdModel.dart';

class NewsDetailScreenCubit extends Cubit<NewsDetailScreenState> {
  NewsDetailScreenCubit() : super(DetailsScreenInitial());

  NewsDetailScreenRepo newsDetailsRepo =
      NewsDetailScreenRepo(networkRequest: NetworkRequest());

  late ApiResponse<NewsDetailsByIdModel> newsDetailById;
  late ApiResponse<List<NewsCommentsModel>> newsComments;

  Future<void> getIdWiseNewsDetails(String nId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsDetailById = await newsDetailsRepo.getNewsDetailsById(newsId: nId);
        if (newsDetailById.isSuccess) {

          getNewsComments(nId);
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

  Future<void> getNewsComments(String nId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsComments = await newsDetailsRepo.getNewsComments(newsId: nId);
        if (newsComments.isSuccess) {
          print("HELLO......54321.................");
          emit(NewsCommentsLoaded(
              msg: "Got data",
              newsCommentsModel: newsComments.resObject??[],
            newsDetailByIdModel: newsDetailById.resObject!
          ));
        } else {
          emit(DetailsScreenError(error: newsComments.errorCause));
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
