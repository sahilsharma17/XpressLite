import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../model/categorised_news_detail_model.dart';
import '../../../../model/reposeCallBack.dart';
import '../../../../network_configs/networkRequest.dart';
import '../repo/GetCategoryWiseNewsDetatailsRepo.dart';

part 'getCategoryWiseNewsDetails_state.dart';

class GetCategoryWiseNewsDetailsCubit
    extends Cubit<GetCategoryWiseNewsDetailsState> {
  GetCategoryWiseNewsDetailsCubit()
      : super(GetCategoryWiseNewsDetailsInitial());

  GetCategoryWiseNewsDetailsRepo getCategoryWiseNewsDetailsRepo =
      GetCategoryWiseNewsDetailsRepo(networkRequest: NetworkRequest());
  late ApiResponse<List<CategorisedNewsDetailsModel>> newsModel;

  void getCategoryWiseNewsDetails() async {
    try {
      emit(GetCategoryWiseNewsDetailsLoading());
      if (await MethodUtils.isInternetPresent()) {
        newsModel =
            await getCategoryWiseNewsDetailsRepo.getCategoryWiseNewsDetails();
        if (newsModel.isSuccess) {
          // MethodUtils.toast(newsModel.resObject.toString()!);
          emit(GetCategoryWiseNewsDetailsLoaded(
              msg: "Got Category Wise News Details",
              newsDetailsModel: newsModel.resObject));
        } else {
          emit(GetCategoryWiseNewsDetailsError(error: newsModel.errorCause));
        }
      } else {
        emit(GetCategoryWiseNewsDetailsError(
            error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(GetCategoryWiseNewsDetailsError(error: e.toString()));
    }
  }

  void refresh() {
    emit(GetCategoryWiseNewsDetailsInitial());
  }
}
