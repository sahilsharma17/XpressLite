import 'package:xpresslite/model/newsCommentsModel.dart';

import '../../../model/PaginatedNewsModel.dart';
import '../../../model/newsDetailsByIdModel.dart';
import '../../../model/newsFeaturesModel.dart';

abstract class NewsDetailScreenState {}

class DetailsScreenInitial extends NewsDetailScreenState {}

class DetailsScreenLoading extends NewsDetailScreenState {}

class NewsDetailsLoaded extends NewsDetailScreenState {
  String msg;
  List<NewsCommentsModel>? newsCommentsModel;
  NewsDetailsByIdModel? newsDetailByIdModel;
  NewsFeaturesModel? newsFeaturesModel;
  List<PaginatedNewsModel>? relatedHappeningModel;
  List? pComment;
  List? delComment;
  List? updateComment;
  List? replyComment;
  List? rating;

  NewsDetailsLoaded(
      {required this.msg,
      this.newsCommentsModel,
      this.newsDetailByIdModel,
      this.newsFeaturesModel,
      this.relatedHappeningModel,
      this.pComment,
      this.delComment,
      this.updateComment,
      this.replyComment,
      this.rating});
}

class DetailsScreenError extends NewsDetailScreenState {
  String error;

  DetailsScreenError({required this.error});
}
