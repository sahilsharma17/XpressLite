


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/home/cubit/home_state.dart';
import 'package:xpresslite/screens/home/repo/home_repo.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/PaginatedNewsModel .dart';
import '../../../model/UpcomingEventBannerModel.dart';
import '../../../model/categorised_news_detail_model.dart';
import '../../../model/reposeCallBack.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepo homeRepo = HomeRepo(networkRequest: NetworkRequest());
  late ApiResponse<List<EventBannerModel>> eventModel;

  late ApiResponse<List<NewsBannerModel>> newsModel;

  late ApiResponse<List<PaginatedNewsModel>> happingModel;

  late ApiResponse<List<PaginatedNewsModel>> awardRecoModel;

  late ApiResponse newsFavs;

  void getNewsBanner() async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsModel = await homeRepo.getNewsBanner();
        if (newsModel.isSuccess) {
          getHappenings();
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


  void getEventBanner() async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        eventModel = await homeRepo.getEventBanner();
        if (eventModel.isSuccess) {
          getAwardsRecog();
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

  void getHappenings() async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        happingModel = await homeRepo.getHappening();
        if (happingModel.isSuccess) {
          getEventBanner();
        } else {
          emit(HomeError(error: happingModel.errorCause));
        }
      } else {
        emit(HomeError(
            error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void getAwardsRecog() async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        awardRecoModel = await homeRepo.getAwardRecog();
        if (eventModel.isSuccess) {
          emit(HomeLoaded(
            msg: "Got upcoming event banner",
            newsBannerModel: newsModel.resObject,
            eventModel: eventModel.resObject,
            pHappeningModel: happingModel.resObject,
            pAwardRecoModel: awardRecoModel.resObject
          ));
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

  void updateFavNews(int newsId, bool favValue) async {
    try {
      emit(HomeLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsFavs = await homeRepo.newsFav(newsId, favValue);
        if (eventModel.isSuccess) {
          emit(HomeLoaded(
              msg: "Updated Fav",
              newsBannerModel: newsModel.resObject,
              eventModel: eventModel.resObject,
              pHappeningModel: happingModel.resObject,
              pAwardRecoModel: awardRecoModel.resObject
          ));
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


  void refresh() {
    emit(HomeInitial());
  }

}