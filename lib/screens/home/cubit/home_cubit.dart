


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/home/cubit/home_state.dart';
import 'package:xpresslite/screens/home/repo/home_repo.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/UpcomingEventBannerModel.dart';
import '../../../model/categorised_news_detail_model.dart';
import '../../../model/reposeCallBack.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepo homeRepo = HomeRepo(networkRequest: NetworkRequest());
  late ApiResponse<List<EventBannerModel>> eventModel;

  late ApiResponse<List<CategorisedNewsDetailsModel>> newsModel;


  void getEventBanner() async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        eventModel = await homeRepo.getEventBanner();
        if (eventModel.isSuccess) {
          // MethodUtils.toast(newsModel.resObject.toString()!);
          print("HELLO.......................");
          emit(EventBannerLoaded(
              msg: "Got upcoming event banner",
              eventModel: eventModel.resObject));
        } else {
          emit(HomeError(error: eventModel.errorCause));
        }
      } else {
        emit(HomeError(
            error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void getCategoryWiseNewsDetails() async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsModel = await homeRepo.getCategoryWiseNewsDetails();
        if (newsModel.isSuccess) {
          print("HELLO");
          // MethodUtils.toast(newsModel.resObject.toString()!);
          emit(HomeLoaded(
              msg: "Got Category Wise News Details",
              newsDetailsModel: newsModel.resObject));
        } else {
          emit(HomeError(error: newsModel.errorCause));
        }
      } else {
        emit(HomeError(
            error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void refresh() {
    emit(HomeInitial());
  }

}