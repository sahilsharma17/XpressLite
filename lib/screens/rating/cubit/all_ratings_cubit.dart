import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';
import 'package:xpresslite/helper/constant/appMessages.dart';
import 'package:xpresslite/model/reposeCallBack.dart';
import 'package:xpresslite/network_configs/networkRequest.dart';
import 'package:xpresslite/screens/rating/repo/all_ratings_repo.dart';

import '../../../model/AllRatersModel.dart';

part 'all_ratings_state.dart';

class AllRatingsCubit extends Cubit<AllRatingsState> {
  AllRatingsCubit() : super(AllRatingsInitial());

  AllRatingsRepo allRatingsRepo =
      AllRatingsRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<AllRatingModel>> allRaters;

  Future<void> getAllRaters(int newsId) async {
    
    
    try {
      emit(AllRatingsLoading());
      if (await MethodUtils.isInternetPresent()) {
        allRaters = await allRatingsRepo.allRaters(newsId: newsId);
        if (allRaters.isSuccess) {
          emit(
            AllRatingsLoaded(msg: 'Got raters', allRaters: allRaters.resObject),
          );
        } else {
          emit(AllRatingsError(error: allRaters.errorCause));
        }
      } else {
        emit(AllRatingsError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(AllRatingsError(error: e.toString()));
    }
  }

  void refresh() {
    emit(AllRatingsInitial());
  }
}
