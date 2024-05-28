

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/home/eventBanner/cubit/eventBanner_state.dart';
import 'package:xpresslite/screens/home/eventBanner/repo/eventBannerRepo.dart';

import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../model/UpcomingEventBannerModel.dart';

class EventBannerCubit extends Cubit<EventBannerState> {
  EventBannerCubit() : super(EventBannerInitial());

  EventBannerRepo eventBannerRepo = EventBannerRepo(networkRequest: NetworkRequest());
  late ApiResponse<EventBannerModel> eventModel;

  void getEventBanner() async {
    try {
      emit(EventBannerLoading());
      if (await MethodUtils.isInternetPresent()) {
        eventModel = await eventBannerRepo.getEventBanner();
        if (eventModel.isSuccess) {
          // MethodUtils.toast(newsModel.resObject.toString()!);
          emit(EventBannerLoaded(
              msg: "Got Category Wise News Details",
              eventModel: eventModel.resObject));
        } else {
          emit(EventBannerError(error: eventModel.errorCause));
        }
      } else {
        emit(EventBannerError(
            error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(EventBannerError(error: e.toString()));
    }
  }

  void refresh() {
    emit(EventBannerInitial());
  }

}