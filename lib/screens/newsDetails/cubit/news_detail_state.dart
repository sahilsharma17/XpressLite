import 'package:xpresslite/model/newsCommentsModel.dart';

import '../../../model/PaginatedNewsModel .dart';
import '../../../model/newsDetailsByIdModel.dart';
import '../../../model/newsFeaturesModel.dart';

abstract class NewsDetailScreenState {}

class DetailsScreenInitial extends NewsDetailScreenState {}

class DetailsScreenLoading extends NewsDetailScreenState {}

class NewsDetailsLoaded extends NewsDetailScreenState {
  String msg;
  NewsDetailsByIdModel? newsDetailByIdModel;

  NewsDetailsLoaded({
    required this.msg,
    this.newsDetailByIdModel,
  });
}

class NewsCommentsLoaded extends NewsDetailScreenState {
  String msg;
  List<NewsCommentsModel>? newsCommentsModel;
  NewsDetailsByIdModel? newsDetailByIdModel;
  NewsFeaturesModel? newsFeaturesModel;
  List<PaginatedNewsModel>? relatedHappeningModel;
  List? pComment;

  NewsCommentsLoaded(
      {required this.msg,
      this.newsCommentsModel,
      this.newsDetailByIdModel,
      this.newsFeaturesModel,
      this.relatedHappeningModel,
      this.pComment});
}

class DetailsScreenError extends NewsDetailScreenState {
  String error;
  DetailsScreenError({required this.error});
}
