part of 'reply_cubit.dart';

@immutable
sealed class ReplyState {}

final class ReplyInitial extends ReplyState {}

class ReplyLoaded extends ReplyState {
  String msg;
  List<ReplyCommentModel>? replies;
  List? reply;

  ReplyLoaded({required this.msg, required this.replies, this.reply});
}

class ReplyLoading extends ReplyState {}

class ReplyError extends ReplyState {
  String error;

  ReplyError({required this.error});
}
