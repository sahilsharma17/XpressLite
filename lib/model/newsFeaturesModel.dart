class NewsFeaturesModel {
  int? totalLikes;
  int? totalViews;
  int? totalComments;
  String? newsLiked;
  bool? newsViewed;
  bool? isFavourite;

  NewsFeaturesModel(
      {this.totalLikes,
        this.totalViews,
        this.totalComments,
        this.newsLiked,
        this.newsViewed,
        this.isFavourite});

  NewsFeaturesModel.fromJson(Map<String, dynamic> json) {
    totalLikes = json['totalLikes'];
    totalViews = json['totalViews'];
    totalComments = json['totalComments'];
    newsLiked = json['newsLiked'];
    newsViewed = json['newsViewed'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalLikes'] = this.totalLikes;
    data['totalViews'] = this.totalViews;
    data['totalComments'] = this.totalComments;
    data['newsLiked'] = this.newsLiked;
    data['newsViewed'] = this.newsViewed;
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}
