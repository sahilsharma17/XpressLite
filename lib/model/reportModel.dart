class ReportModel {
  int? pdfListId;
  String? title;
  String? category;
  String? directorName;
  String? createdDate;
  int? viewed;
  int? notViewed;

  ReportModel(
      {this.pdfListId,
        this.title,
        this.category,
        this.directorName,
        this.createdDate,
        this.viewed,
        this.notViewed});

  ReportModel.fromJson(Map<String, dynamic> json) {
    pdfListId = json['pdfListId'];
    title = json['title'];
    category = json['category'];
    directorName = json['directorName'];
    createdDate = json['createdDate'];
    viewed = json['viewed'] ?? 0;
    notViewed = json['notViewed'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pdfListId'] = this.pdfListId;
    data['title'] = this.title;
    data['category'] = this.category;
    data['directorName'] = this.directorName;
    data['createdDate'] = this.createdDate;
    data['viewed'] = this.viewed;
    data['notViewed'] = this.notViewed;
    return data;
  }
}
