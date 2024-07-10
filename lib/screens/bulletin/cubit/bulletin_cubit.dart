import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../helper/constant/appMessages.dart';
import '../../../model/BulletinPdfModel.dart';
import '../../../model/reposeCallBack.dart';
import '../../../network_configs/networkRequest.dart';
import '../repo/bulletin_repo.dart';

part 'bulletin_state.dart';

class BulletinCubit extends Cubit<BulletinState> {
  BulletinCubit() : super(BulletinInitial());

  BulletinsRepo reportsRepo = BulletinsRepo(networkRequest: NetworkRequest());

  late ApiResponse<List<BulletinPdfModel>> bulletins;

  Future<void> getBulletins(String month, String date) async {
    try {
      emit(BulletinLoading());
      if (await MethodUtils.isInternetPresent()) {
        bulletins = await reportsRepo.getBulletinPdf(month: month, date: date);
        if (bulletins.isSuccess) {
          emit(BulletinLoaded(
              msg: 'Got reports', bulletinModel: bulletins.resObject ?? []));
        } else {
          emit(BulletinError(error: bulletins.errorCause));
        }
      } else {
        emit(BulletinError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(BulletinError(error: e.toString()));
    }
  }
}
