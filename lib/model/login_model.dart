
class LoginModel {
  String? id;
  String? name;
  String? profileImage;
  bool? approved;
  bool? isActive;
  String? gender;
  String? accessToken;
  String? refreshToken;
  String? message;
  String? badge;
  String? empId;

  LoginModel(
      {this.id,
      this.name,
      this.profileImage,
      this.approved,
      this.isActive,
      this.gender,
      this.accessToken,
      this.refreshToken,
      this.message,
      this.badge,
      this.empId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profileImage'];
    approved = json['approved'];
    isActive = json['isActive'];
    gender = json['gender'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    message = json['message'];
    badge = json['badge'];
    empId = json['empId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['approved'] = this.approved;
    data['isActive'] = this.isActive;
    data['gender'] = this.gender;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['message'] = this.message;
    data['badge'] = this.badge;
    data['empId'] = this.empId;
    return data;
  }
}