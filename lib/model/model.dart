class Event {
  bool? status;
  String? message;
  List<EventData>? data;

  Event({this.status, this.message, this.data});

  Event.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(new EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventData {
  int? id;
  String? title;
  String? description;
  String? eventShowDate;
  String? imageFileName;
  bool? isActive;
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  String? modifiedBy;
  String? ip;
  bool? isLiked;

  EventData(
      {this.id,
      this.title,
      this.description,
      this.eventShowDate,
      this.imageFileName,
      this.isActive,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.ip,
      this.isLiked});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    eventShowDate = json['eventShowDate'];
    imageFileName = json['imageFileName'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    ip = json['ip'];
    isLiked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['eventShowDate'] = this.eventShowDate;
    data['imageFileName'] = this.imageFileName;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['ip'] = this.ip;
    return data;
  }
}
