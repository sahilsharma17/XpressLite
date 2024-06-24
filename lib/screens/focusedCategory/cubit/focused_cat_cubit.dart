import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/focusedCatModel.dart';
import 'package:xpresslite/screens/focusedCategory/cubit/focused_cat_state.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../repo/focused_cat_repo.dart';

class FocusedCategoryScreenCubit extends Cubit<FocusedCategoryState> {
  FocusedCategoryScreenCubit() : super(FocusedCategoryInitial());

  FocusedCategoryScreenRepo focusedCategoryRepo =
      FocusedCategoryScreenRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<FocusedCategoryModel>> focusedCategory;

  Future<void> getFocusedCategories() async {
    try {
      emit(FocusedCategoryLoading());
      if (await MethodUtils.isInternetPresent()) {
        focusedCategory = await focusedCategoryRepo.getFocusedCategory();
        if (focusedCategory.isSuccess) {
          emit(FocusedCategoryLoaded(
            msg: "Got data",
            focusedCategory: focusedCategory.resObject ?? [],
          ));
        } else {
          emit(FocusedCategoryError(error: focusedCategory.errorCause));
        }
      } else {
        emit(FocusedCategoryError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(FocusedCategoryError(error: e.toString()));
    }
  }

  void refresh() {
    emit(FocusedCategoryInitial());
  }
}
