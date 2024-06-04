class EventBannerModel {
  int? id;
  String? title;
  String? description;
  String? eventShowDate;
  String? imageFileName;
  bool? isActive;
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  String? modifiedBy;
  String? ip;
  bool? isLiked;

  EventBannerModel(
      {this.id,
      this.title,
      this.description,
      this.eventShowDate,
      this.imageFileName,
      this.isActive,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.ip,
      this.isLiked});

  EventBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    eventShowDate = json['eventShowDate'];
    imageFileName = json['imageFileName'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
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
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
