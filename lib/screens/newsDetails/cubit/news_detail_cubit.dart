import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/PaginatedNewsModel%20.dart';
import 'package:xpresslite/model/newsCommentsModel.dart';
import 'package:xpresslite/model/newsFeaturesModel.dart';
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
  late ApiResponse<NewsFeaturesModel> newsFeatures;
  late ApiResponse<List<NewsCommentsModel>> newsComments;
  late ApiResponse<List<PaginatedNewsModel>> relatedHappenings;
  late ApiResponse postedComment;

  Future<void> getIdWiseNewsDetails(String nId, String catId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsDetailById = await newsDetailsRepo.getNewsDetailsById(newsId: nId);
        if (newsDetailById.isSuccess) {
          getNewsFeatures(nId, catId);
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

  Future<void> getNewsFeatures(String nId, String catId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsFeatures = await newsDetailsRepo.getNewsFeatures(newsId: nId);
        if (newsFeatures.isSuccess) {
          getNewsComments(nId, catId);
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

  Future<void> getNewsComments(String nId, String catId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsComments = await newsDetailsRepo.getNewsComments(newsId: nId);
        if (newsComments.isSuccess) {
          getRelatedNews(catId);
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

  Future<void> getRelatedNews(String catId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        relatedHappenings =
            await newsDetailsRepo.getRelatedNews(newsCatId: catId);
        if (newsComments.isSuccess) {
          emit(NewsCommentsLoaded(
            msg: "Got data",
            newsCommentsModel: newsComments.resObject ?? [],
            newsDetailByIdModel: newsDetailById.resObject!,
            newsFeaturesModel: newsFeatures.resObject!,
            relatedHappeningModel: relatedHappenings.resObject ?? [],
          ));
        } else {
          emit(DetailsScreenError(error: relatedHappenings.errorCause));
        }
      } else {
        emit(DetailsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DetailsScreenError(error: e.toString()));
    }
  }

  Future<void> postComment(String nId, String comment,String cId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        postedComment =
            await newsDetailsRepo.postComment(newsId: nId, comment: comment);
        if (postedComment.isSuccess) {
          getIdWiseNewsDetails(nId, cId);

        } else {
          emit(DetailsScreenError(error: postedComment.errorCause));
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
