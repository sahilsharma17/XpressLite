class AllPdfModel {
  int? id;
  String? title;
  String? description;
  int? categoryId;
  int? directorId;
  String? categoryName;
  String? directorName;
  String? pdfFileNames;

  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  
  String? ip;

  AllPdfModel(
      {this.id,
      this.title,
      this.description,
      this.categoryId,
      this.directorId,
      this.categoryName,
      this.directorName,
      this.pdfFileNames,
      this.createdDate,
      this.createdBy,
      this.ip});

  AllPdfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    categoryId = json['categoryId'];
    directorId = json['directorId'];
    categoryName = json['categoryName'];
    directorName = json['directorName'];
    pdfFileNames = json['pdfFileNames'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['directorId'] = this.directorId;
    data['categoryName'] = this.categoryName;
    data['directorName'] = this.directorName;
    data['pdfFileNames'] = this.pdfFileNames;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['ip'] = this.ip;
    return data;
  }
}
