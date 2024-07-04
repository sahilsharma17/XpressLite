

import '../../../model/PaginatedNewsModel .dart';
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
  List<EventBannerModel>? eventModel;
  List<NewsBannerModel>? newsBannerModel;
  List<PaginatedNewsModel>? pHappeningModel;
  List<PaginatedNewsModel>? pAwardRecoModel;


  HomeLoaded({required this.msg, this.eventModel, this.newsBannerModel, this.pHappeningModel, this.pAwardRecoModel});
}

// class NewsFavLoaded extends HomeState {
//   String msg;
//
// }
