class FocusedCategoryModel {
  int? id;
  String? topic;
  int? categoriesId;
  
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  
  String? ip;

  FocusedCategoryModel(
      {this.id,
        this.topic,
        this.categoriesId,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.ip});

  FocusedCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    categoriesId = json['categoriesId'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['categoriesId'] = this.categoriesId;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['ip'] = this.ip;
    return data;
  }
}
