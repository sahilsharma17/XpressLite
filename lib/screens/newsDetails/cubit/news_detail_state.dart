
import '../../../model/newsDetailsByIdModel.dart';

abstract class NewsDetailScreenState {}

class DetailsScreenInitial extends NewsDetailScreenState {}

class DetailsScreenLoading extends NewsDetailScreenState {}

class NewsDetailsLoaded extends NewsDetailScreenState {
  String msg;
  NewsDetailsByIdModel? newsDetailByIdModel;
  NewsDetailsLoaded({required this.msg, this.newsDetailByIdModel});
}

class DetailsScreenError extends NewsDetailScreenState {
  String error;
  DetailsScreenError({required this.error});
}