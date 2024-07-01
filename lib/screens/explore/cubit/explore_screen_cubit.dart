import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/reposeCallBack.dart';
import '../../../model/searchModel.dart';
import '../../../network_configs/networkRequest.dart';
import '../repo/explore_screen_repo.dart';

part 'explore_screen_state.dart';

class ExploreScreenCubit extends Cubit<ExploreScreenState> {
  ExploreScreenCubit() : super(ExploreScreenInitial());


  ExploreScreenRepo exploreRepo =
  ExploreScreenRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<SearchModel>> searchedNews;

  Future<void> searchingNews(String sText) async {
    try {
      emit(ExploreScreenLoading());
      if (await MethodUtils.isInternetPresent()) {
        searchedNews = await exploreRepo.searchNews(searchText: sText);
        if (searchedNews.isSuccess) {
          emit(ExploreScreenLoaded(
            msg: "Got data",
            searchedNewsModel: searchedNews.resObject ?? [],
          ));
        } else {
          emit(ExploreScreenError(error: searchedNews.errorCause));
        }
      } else {
        emit(ExploreScreenError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(ExploreScreenError(error: e.toString()));
    }
  }

  void refresh() {
    emit(ExploreScreenInitial());
  }
}
