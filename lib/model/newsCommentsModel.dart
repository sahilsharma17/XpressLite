
class NewsCommentsModel {

  String? name;
  String? profileImage;
  int? commentId;
  String? comment;
  int? totalCommentLikes;
  String? likeType;
  int? commentRepliesCount;
  List<Replies>? replies;
  bool? isActive;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? ip;

  NewsCommentsModel(
      {this.name,
        this.profileImage,
        this.commentId,
        this.comment,
        this.totalCommentLikes,
        this.likeType,
        this.commentRepliesCount,
        this.replies,
        this.isActive,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.ip});

  NewsCommentsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    profileImage = json['profileImage'] ?? "";
    commentId = json['commentId'] ?? 0;
    comment = json['comment'] ?? "";
    totalCommentLikes = json['totalCommentLikes'] ?? 0;
    likeType = json['likeType'] ?? "";
    commentRepliesCount = json['commentRepliesCount'] ?? 0;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    isActive = json['isActive'] ?? true;
    createdDate = json['createdDate'] ?? "";
    createdBy = json['createdBy'] ?? "";
    modifiedDate = json['modifiedDate'] ?? "";
    modifiedBy = json['modifiedBy'] ?? "";
    ip = json['ip'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['commentId'] = this.commentId;
    data['comment'] = this.comment;
    data['totalCommentLikes'] = this.totalCommentLikes;
    data['likeType'] = this.likeType;
    data['commentRepliesCount'] = this.commentRepliesCount;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}

class Replies {
  String? name;
  String? profileImage;
  int? commentReplyId;
  String? commentsReply;
  int? totalCommentReplyLikes;
  String? replyLikeType;
  bool? isActive;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? ip;

  Replies(
      {this.name,
        this.profileImage,
        this.commentReplyId,
        this.commentsReply,
        this.totalCommentReplyLikes,
        this.replyLikeType,
        this.isActive,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.ip});

  Replies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
    commentReplyId = json['commentReplyId'];
    commentsReply = json['commentsReply'];
    totalCommentReplyLikes = json['totalCommentReplyLikes'];
    replyLikeType = json['replyLikeType'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['commentReplyId'] = this.commentReplyId;
    data['commentsReply'] = this.commentsReply;
    data['totalCommentReplyLikes'] = this.totalCommentReplyLikes;
    data['replyLikeType'] = this.replyLikeType;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
