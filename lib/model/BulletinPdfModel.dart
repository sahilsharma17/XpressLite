class BulletinPdfModel {
  int? id;
  String? title;
  String? description;
  String? pdfFileName;
  String? insertDate;
  bool? isActive;
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  String? modifiedBy;
  String? ip;

  BulletinPdfModel(
      {this.id,
        this.title,
        this.description,
        this.pdfFileName,
        this.insertDate,
        this.isActive,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.ip});

  BulletinPdfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    pdfFileName = json['pdfFileName'];
    insertDate = json['insertDate'];
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
    data['title'] = this.title;
    data['description'] = this.description;
    data['pdfFileName'] = this.pdfFileName;
    data['insertDate'] = this.insertDate;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
