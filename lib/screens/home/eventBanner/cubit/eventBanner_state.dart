
import '../../../../model/UpcomingEventBannerModel.dart';

abstract class EventBannerState {}

class EventBannerInitial extends EventBannerState {}

class EventBannerLoaded extends EventBannerState {
  String msg;
  EventBannerModel? eventModel;
  EventBannerLoaded({required this.msg, this.eventModel});
}

class EventBannerLoading extends EventBannerState {}

class EventBannerError extends EventBannerState {
  String error;
  EventBannerError({required this.error});
}

