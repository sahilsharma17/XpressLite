part of 'bulletin_cubit.dart';

@immutable
sealed class BulletinState {}

final class BulletinInitial extends BulletinState {}

class BulletinLoaded extends BulletinState {
  String msg;
  List<BulletinPdfModel> bulletinModel;
  BulletinLoaded({required this.msg, required this.bulletinModel});
}

class BulletinLoading extends BulletinState {}

class BulletinError extends BulletinState {
  String error;

  BulletinError({required this.error});
}
