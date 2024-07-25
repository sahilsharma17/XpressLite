class DirectorCatModel {
  int? id;
  int? categoryId;
  int? hierarchy;
  String? directorName;
  String? directorType;
  String? directorImage;
  
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  
  String? ip;

  DirectorCatModel(
      {this.id,
        this.categoryId,
        this.hierarchy,
        this.directorName,
        this.directorType,
        this.directorImage,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.ip});

  DirectorCatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    hierarchy = json['hierarchy'];
    directorName = json['directorName'];
    directorType = json['directorType'];
    directorImage = json['directorImage'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['hierarchy'] = this.hierarchy;
    data['directorName'] = this.directorName;
    data['directorType'] = this.directorType;
    data['directorImage'] = this.directorImage;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['ip'] = this.ip;
    return data;
  }
}
