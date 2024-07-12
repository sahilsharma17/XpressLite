import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../repo/favs_repo.dart';

part 'favs_screen_state.dart';

class FavsScreenCubit extends Cubit<FavsScreenState> {
  FavsScreenCubit() : super(FavsScreenInitial());

  FavsNewsScreenRepo favRepo =
  FavsNewsScreenRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<PaginatedNewsModel>> newsFavs;
  late ApiResponse isFav;


  Future<void> getNewsFavs() async {
    try {
      emit(FavsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsFavs = await favRepo.getFavNews();
        if (newsFavs.isSuccess) {
          emit(FavsScreenLoaded(
            msg: "Got data",
            newsModel: newsFavs.resObject ?? [],
          ));
        } else {
          emit(FavsScreenError(error: newsFavs.errorCause));
        }
      } else {
        emit(FavsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(FavsScreenError(error: e.toString()));
    }
  }

  void updateFavNews(int newsId, bool favValue) async {
    try {
      emit(FavsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        isFav = await favRepo.newsFav(newsId, favValue);
        newsFavs.resObject
            ?.removeWhere((item) => item.id == newsId);
        if (newsFavs.isSuccess) {
          emit(FavsScreenLoaded(
            msg: "Got data",
            newsModel: newsFavs.resObject ?? [],
          ));
        } else {
          emit(FavsScreenError(error: newsFavs.errorCause));
        }
      } else {
        emit(FavsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(FavsScreenError(error: e.toString()));
    }
  }

  void refresh() {
    emit(FavsScreenInitial());
  }
}


