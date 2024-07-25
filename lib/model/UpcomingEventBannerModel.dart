class EventBannerModel {
  int? id;
  String? title;
  String? description;
  String? eventShowDate;
  String? imageFileName;
  
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  
  String? ip;
  bool? isLiked;

  EventBannerModel(
      {this.id,
      this.title,
      this.description,
      this.eventShowDate,
      this.imageFileName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.ip,
      this.isLiked});

  EventBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    eventShowDate = json['eventShowDate'];
    imageFileName = json['imageFileName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    ip = json['ip'];
    isLiked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['eventShowDate'] = this.eventShowDate;
    data['imageFileName'] = this.imageFileName;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['ip'] = this.ip;
    return data;
  }
}
