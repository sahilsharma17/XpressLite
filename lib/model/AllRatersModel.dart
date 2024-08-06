class AllRatingModel {
  String? name;
  String? profileImage;
  int? newsDetailsId;
  int? newsRated;
  String? divisionName;
  String? location;
  String? createdDate;
  String? createdBy;
  String? modifiedBy;
  String? ip;

  AllRatingModel(
      {this.name,
        this.profileImage,
        this.newsDetailsId,
        this.newsRated,
        this.divisionName,
        this.location,
        this.createdDate,
        this.createdBy,
        this.modifiedBy,
        this.ip});

  AllRatingModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
    newsDetailsId = json['newsDetailsId'];
    newsRated = json['newsRated'];
    divisionName = json['divisionName'];
    location = json['location'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['newsDetailsId'] = this.newsDetailsId;
    data['newsRated'] = this.newsRated;
    data['divisionName'] = this.divisionName;
    data['location'] = this.location;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
