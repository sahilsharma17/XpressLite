class BulletinPdfModel {
  int? id;
  String? title;
  String? description;
  String? pdfFileName;
  String? insertDate;
  String? createdDate;
  String? createdBy;

  String? ip;

  BulletinPdfModel(
      {this.id,
        this.title,
        this.description,
        this.pdfFileName,
        this.insertDate,
        this.createdDate,
        this.createdBy,
        this.ip});

  BulletinPdfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    pdfFileName = json['pdfFileName'];
    insertDate = json['insertDate'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['pdfFileName'] = pdfFileName;
    data['insertDate'] = insertDate;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['ip'] = ip;
    return data;
  }
}
