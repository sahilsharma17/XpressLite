class NewsBannerModel {
  int? id;
  String? title;
  String? imageFileNames;
  int? categoryId;

  NewsBannerModel({this.id, this.title, this.imageFileNames, this.categoryId});

  NewsBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageFileNames = json['imageFileNames'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imageFileNames'] = this.imageFileNames;
    data['categoryId'] = this.categoryId;
    return data;
  }
}

