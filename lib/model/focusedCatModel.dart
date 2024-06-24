class FocusedCategoryModel {
  int? id;
  String? topic;
  int? categoriesId;
  bool? isActive;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? ip;

  FocusedCategoryModel(
      {this.id,
        this.topic,
        this.categoriesId,
        this.isActive,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.ip});

  FocusedCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    categoriesId = json['categoriesId'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['categoriesId'] = this.categoriesId;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
