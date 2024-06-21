import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/screens/category/InsideCategory/cubit/directors_category_state.dart';
import 'package:xpresslite/screens/category/InsideCategory/repo/directors_category_repo.dart';

import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../model/directorsCatModel.dart';
import '../../../../network_configs/networkRequest.dart';

class DirectorsCategoryCubit extends Cubit<DirectorsCategoryState> {
  DirectorsCategoryCubit() : super(DirectorsCategoryInitial());

  DirCatRepo directorRepo = DirCatRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<DirectorCatModel>> categorisedDirectorModel;

  void getDirectors() async {
    try {
      emit(DirectorsCategoryLoading());
      if (await MethodUtils.isInternetPresent()) {
        categorisedDirectorModel = await directorRepo.getDirectorCategory();
        if (categorisedDirectorModel.isSuccess) {
          emit(DirectorsCategoryLoaded(
            msg: "Got Director Category",
              directorCatModel: categorisedDirectorModel.resObject,
          ));
        } else {
          emit(DirectorsCategoryError(
              error: categorisedDirectorModel.errorCause));
        }
      } else {
        emit(DirectorsCategoryError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(DirectorsCategoryError(error: e.toString()));
    }
  }

  void refresh() {
    emit(DirectorsCategoryInitial());
  }
}
