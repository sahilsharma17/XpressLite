class ReplyCommentModel {
  String? name;
  String? profileImage;
  int? commentReplyId;
  String? commentsReply;
  int? totalCommentReplyLikes;
  String? replyLikeType;
  
  String? createdDate;
  Null? createdBy;
  Null? modifiedDate;
  Null? modifiedBy;
  Null ip;

  ReplyCommentModel(
      {this.name,
        this.profileImage,
        this.commentReplyId,
        this.commentsReply,
        this.totalCommentReplyLikes,
        this.replyLikeType,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.ip});

  ReplyCommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
    commentReplyId = json['commentReplyId'];
    commentsReply = json['commentsReply'];
    totalCommentReplyLikes = json['totalCommentReplyLikes'];
    replyLikeType = json['replyLikeType'];
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
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
