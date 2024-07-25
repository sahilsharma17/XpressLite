class SearchModel {
  int? id;
  String? leaderName;
  String? divisionName;
  String? location;
  String? category;
  int? leadershipId;
  int? divisionsId;
  
  int? categoryId;
  int? topicsTagId;
  String? topic;
  String? title;
  String? summary;
  String? description;
  String? youtubeVideoLink;
  String? pdfFileLink;
  String? readTime;
  String? happeningDate;
  String? scheduleHappeningDate;
  bool? downloadable;
  bool? shareable;

  bool? sendNotification;
  bool? saveAsDraft;
  List<String>? imageFileNames;
  bool? isFavourite;
  Null? calculatedRating;
  Null? rating;
  Null? newsHashtagsOnNews;
  
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  
  String? ip;

  SearchModel(
      {this.id,
        this.leaderName,
        this.divisionName,
        this.location,
        this.category,
        this.leadershipId,
        this.divisionsId,
        this.categoryId,
        this.topicsTagId,
        this.topic,
        this.title,
        this.summary,
        this.description,
        this.youtubeVideoLink,
        this.pdfFileLink,
        this.readTime,
        this.happeningDate,
        this.scheduleHappeningDate,
        this.downloadable,
        this.shareable,
        this.sendNotification,
        this.saveAsDraft,
        this.imageFileNames,
        this.isFavourite,
        this.calculatedRating,
        this.rating,
        this.newsHashtagsOnNews,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.ip});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    leaderName = json['leaderName'];
    divisionName = json['divisionName'];
    location = json['location'];
    category = json['category'];
    leadershipId = json['leadershipId'];
    divisionsId = json['divisionsId'];
    categoryId = json['categoryId'];
    topicsTagId = json['topicsTagId'];
    topic = json['topic'];
    title = json['title'];
    summary = json['summary'];
    description = json['description'];
    youtubeVideoLink = json['youtubeVideoLink'];
    pdfFileLink = json['pdfFileLink'];
    readTime = json['readTime'];
    happeningDate = json['happeningDate'];
    scheduleHappeningDate = json['scheduleHappeningDate'];
    downloadable = json['downloadable'];
    shareable = json['shareable'];
    sendNotification = json['sendNotification'];
    saveAsDraft = json['saveAsDraft'];
    imageFileNames = json['imageFileNames'].cast<String>();
    isFavourite = json['isFavourite'];
    calculatedRating = json['calculatedRating'];
    rating = json['rating'];
    newsHashtagsOnNews = json['newsHashtagsOnNews'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leaderName'] = this.leaderName;
    data['divisionName'] = this.divisionName;
    data['location'] = this.location;
    data['category'] = this.category;
    data['leadershipId'] = this.leadershipId;
    data['divisionsId'] = this.divisionsId;
    data['categoryId'] = this.categoryId;
    data['topicsTagId'] = this.topicsTagId;
    data['topic'] = this.topic;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['description'] = this.description;
    data['youtubeVideoLink'] = this.youtubeVideoLink;
    data['pdfFileLink'] = this.pdfFileLink;
    data['readTime'] = this.readTime;
    data['happeningDate'] = this.happeningDate;
    data['scheduleHappeningDate'] = this.scheduleHappeningDate;
    data['downloadable'] = this.downloadable;
    data['shareable'] = this.shareable;
    data['sendNotification'] = this.sendNotification;
    data['saveAsDraft'] = this.saveAsDraft;
    data['imageFileNames'] = this.imageFileNames;
    data['isFavourite'] = this.isFavourite;
    data['calculatedRating'] = this.calculatedRating;
    data['rating'] = this.rating;
    data['newsHashtagsOnNews'] = this.newsHashtagsOnNews;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['ip'] = this.ip;
    return data;
  }
}
