

import '../../../model/UpcomingEventBannerModel.dart';
import '../../../model/categorised_news_detail_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  String error;
  HomeError({required this.error});
}

class HomeLoaded extends HomeState {
  String msg;
  List<CategorisedNewsDetailsModel>? newsDetailsModel;

  HomeLoaded({required this.msg, this.newsDetailsModel, });
}

class EventBannerLoaded extends HomeState {
  String msg;
  List<EventBannerModel>? eventModel;

  EventBannerLoaded({required this.msg, this.eventModel});
}
