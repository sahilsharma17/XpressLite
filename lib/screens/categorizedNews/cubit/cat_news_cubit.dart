import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/screens/categorizedNews/cubit/cat_news_state.dart';
import 'package:xpresslite/screens/categorizedNews/repo/cat_news_repo.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/PaginatedNewsModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';

class CatNewsScreenCubit extends Cubit<CatNewsScreenState> {
  CatNewsScreenCubit() : super(CatNewsScreenInitial());

  CatNewsScreenRepo catNewsRepo =
      CatNewsScreenRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<PaginatedNewsModel>> categorizedNews;

  Future<void> getRelatedNews(String catId) async {
    try {
      emit(CatNewsScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        categorizedNews = await catNewsRepo.getCatNews(newsCatId: catId);
        if (categorizedNews.isSuccess) {
          emit(CatNewsScreenLoaded(
            msg: "Got data",
            newsByCategory: categorizedNews.resObject ?? [],
          ));
        } else {
          emit(CatNewsScreenError(error: categorizedNews.errorCause));
        }
      } else {
        emit(CatNewsScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(CatNewsScreenError(error: e.toString()));
    }
  }

  void refresh() {
    emit(CatNewsScreenInitial());
  }
}
