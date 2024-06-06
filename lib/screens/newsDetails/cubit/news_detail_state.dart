
import 'package:xpresslite/model/newsCommentsModel.dart';

import '../../../model/newsDetailsByIdModel.dart';

abstract class NewsDetailScreenState {}

class DetailsScreenInitial extends NewsDetailScreenState {}

class DetailsScreenLoading extends NewsDetailScreenState {}

class NewsDetailsLoaded extends NewsDetailScreenState {
  String msg;
  NewsDetailsByIdModel? newsDetailByIdModel;
  // List<NewsCommentsModel>? newsCommentsModel;
  NewsDetailsLoaded({required this.msg, this.newsDetailByIdModel, });
}

class NewsCommentsLoaded extends NewsDetailScreenState {
  String msg;
  List<NewsCommentsModel>? newsCommentsModel;
  NewsDetailsByIdModel? newsDetailByIdModel;

  NewsCommentsLoaded({required this.msg, this.newsCommentsModel,this.newsDetailByIdModel});
}

class DetailsScreenError extends NewsDetailScreenState {
  String error;
  DetailsScreenError({required this.error});
}