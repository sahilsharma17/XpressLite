import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/newsCommentsModel.dart';
import 'package:xpresslite/model/newsFeaturesModel.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/newsDetails/cubit/news_detail_state.dart';
import 'package:xpresslite/screens/newsDetails/repo/news_details_repo.dart';

import '../../../helper/app_utilities/date_utils.dart';
import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/PaginatedNewsModel.dart';
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
  late ApiResponse deletedComment;
  late ApiResponse deletedReply;
  late ApiResponse updatedComment;
  late ApiResponse newsFavs;
  late ApiResponse replyComment;
  late ApiResponse postRate;

  Future<void> getIdWiseNewsDetails(int nId, String catId) async {
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

  Future<void> getNewsFeatures(int nId, String catId) async {
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

  Future<void> getNewsComments(int nId, String catId) async {
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
          emit(NewsDetailsLoaded(
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

  Future<void> postComment(int nId, String comment, String cId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        postedComment =
            await newsDetailsRepo.postComment(newsId: nId, comment: comment);
        if (postedComment.isSuccess) {
          newsComments.resObject?.insert(
              0,
              NewsCommentsModel(
                name: "dharmender",
                profileImage:
                    "https://xpress.businesstowork.com/Admin/img/ProfileImages/default_user100.jpg",
                commentId: 100,
                comment: comment,
                totalCommentLikes: 0,
                likeType: "Like",
                commentRepliesCount: 0,
                replies: [],
                createdDate: AppDateUtils.getFormattedDateWithTime().toString(),
                createdBy: '',
                modifiedDate: '',
                ip: '',
              ));
          emit(NewsDetailsLoaded(
            msg: "Got data",
            newsCommentsModel: newsComments.resObject ?? [],
            newsDetailByIdModel: newsDetailById.resObject!,
            newsFeaturesModel: newsFeatures.resObject!,
            relatedHappeningModel: relatedHappenings.resObject ?? [],
          ));

          // getIdWiseNewsDetails(nId, cId);
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

  Future<void> deleteComment(
      int nId, String cId, int nComId, String ncrId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        deletedComment = await newsDetailsRepo.delComment(
            nComId: nComId, nComReplyId: ncrId);
        if (deletedComment.isSuccess) {
          newsComments.resObject
              ?.removeWhere((item) => item.commentId == nComId);
          emit(NewsDetailsLoaded(
            msg: "Got data",
            newsCommentsModel: newsComments.resObject ?? [],
            newsDetailByIdModel: newsDetailById.resObject!,
            newsFeaturesModel: newsFeatures.resObject!,
            relatedHappeningModel: relatedHappenings.resObject ?? [],
          ));
        } else {
          emit(DetailsScreenError(error: deletedComment.errorCause));
        }
      } else {
        emit(DetailsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DetailsScreenError(error: e.toString()));
    }
  }

  Future<void> deleteReply(
      int nId, String cId, int nComId, String ncrId) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        deletedComment = await newsDetailsRepo.delReply(
          nComReplyId: ncrId);
        if (deletedComment.isSuccess) {
          newsComments.resObject?.forEach((comment) {
            comment.replies?.removeWhere((reply) => reply.commentReplyId.toString() == ncrId);
          });

          emit(NewsDetailsLoaded(
            msg: "Got data",
            newsCommentsModel: newsComments.resObject ?? [],
            newsDetailByIdModel: newsDetailById.resObject!,
            newsFeaturesModel: newsFeatures.resObject!,
            relatedHappeningModel: relatedHappenings.resObject ?? [],
          ));
        } else {
          emit(DetailsScreenError(error: deletedComment.errorCause));
        }
      } else {
        emit(DetailsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DetailsScreenError(error: e.toString()));
    }
  }

  Future<void> updateComment(
      int nId, String cId, int nComId, String newComment) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        updatedComment = await newsDetailsRepo.updateComment(
            nComId: nComId, newComment: newComment);
        if (updatedComment.isSuccess) {
          getIdWiseNewsDetails(nId, cId);
        } else {
          emit(DetailsScreenError(error: updatedComment.errorCause));
        }
      } else {
        emit(DetailsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DetailsScreenError(error: e.toString()));
    }
  }

  Future<void> replyOnComment(
      int nId, String cId, int nComId, String reply) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        replyComment = await newsDetailsRepo.postReply(comId : nComId, reply: reply);
        if (replyComment.isSuccess) {
          getIdWiseNewsDetails(nId, cId);
        } else {
          emit(DetailsScreenError(error: replyComment.errorCause));
        }
      } else {
        emit(DetailsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DetailsScreenError(error: e.toString()));
    }
  }

  Future<void> updateFavNews(int newsId, bool favValue) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsFavs = await newsDetailsRepo.newsFav(newsId, favValue);
        if (newsDetailById.isSuccess) {
          emit(NewsDetailsLoaded(
            msg: "Updated Fav",
            newsCommentsModel: newsComments.resObject ?? [],
            newsDetailByIdModel: newsDetailById.resObject!,
            newsFeaturesModel: newsFeatures.resObject!,
            relatedHappeningModel: relatedHappenings.resObject ?? [],
          ));
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

  Future<void> postRating(
      int newsId, String cId, int rating) async {
    try {
      emit(DetailsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        postRate = await newsDetailsRepo.postRating(
            newsId: newsId, rate: rating);
        if (postRate.isSuccess) {

          emit(NewsDetailsLoaded(
            msg: "Got data",
            newsCommentsModel: newsComments.resObject ?? [],
            newsDetailByIdModel: newsDetailById.resObject!,
            newsFeaturesModel: newsFeatures.resObject!,
            relatedHappeningModel: relatedHappenings.resObject ?? [],
          ));
          getIdWiseNewsDetails(newsId, cId);
        } else {
          emit(DetailsScreenError(error: deletedComment.errorCause));
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
