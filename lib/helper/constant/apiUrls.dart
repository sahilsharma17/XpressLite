import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiUrls {
  static String baseUrl(String endPoint) =>
      "https://xpress.businesstowork.com/api/$endPoint";

  static String login = baseUrl("Auth/LoginUser");

  static String VerifyOtp = baseUrl("Auth/VerifyUserotp");

  static String getCategoryWiseNewsDetails =
      baseUrl("NewsDetails/GetCategoryWiseNewsDetails");

  static String upcomingEvent = baseUrl('EventBanner/GetEventBannerList');

  static String idWiseNewsDetails = baseUrl('NewsDetails/GetNewsDetailById');
// by user A with some empl id on A NEWS ID
  static String getNewsCommentDetails =
      baseUrl('NewsDetails/GetNewsCommentDetails');

  static String getNewsFeatures = baseUrl('NewsDetails/GetNewsFeatures');

  static String getNewsPaginated = baseUrl('NewsDetails/GetNewsDetails');

  static String postComment = baseUrl('NewsDetails/CreateNewsComment');

  static String delComment = baseUrl('NewsDetails/DeleteNewsComment');

  static String updateComment = baseUrl('NewsDetails/UpdateNewsComment');

  static String directorCategory =
      baseUrl('NewsDetails/GetDirectorsList?categoryId=6');

  static String getPdfs = baseUrl('NewsDetails/GetPdfLists');

  static String searchNews = baseUrl('NewsDetails/GetNewsDetailsOnSearch');

  static String getFocusedCategory = baseUrl('TopicsTag/GetAll');

  static String createFav = baseUrl('NewsDetails/CreateNewsFavourite');

  static String ceoReports = baseUrl('MisPdfReport/MisPdfList');

  static String otherReports = baseUrl('MisPdfReport/MisBulletinPdfList');

  static String bulletinPdf = baseUrl('BulletinPdf/GetBulletinPdfList');

  static String favs = baseUrl('NewsDetails/GetNewsFavouriteList?createdBy=00500877');


  // for posting a reply on COMMENT
  static String reply = baseUrl('NewsDetails/CommentsCommentReply');

  static String postRating = baseUrl('NewsDetails/CreateNewsRating');

  static String repliesOnComment = baseUrl('NewsDetails/GetNewsCommentRepliesDetails');

  static String allRating = baseUrl('NewsDetails/GetNewsRatedDetails');
}

class AppAuth {
  AppAuth._();

  static String get appTraceReceiverEmail => "gawasthi@planetecomsolutions.com";

  static String get appMailerEmail => "pecsjatin@gmail.com";

  static String get appMailerPassword => "jatinflutter";
}

class AppInfo {
  static const String companyName = "PECS";
  static const String companyAddress = "Delhi";
  static const String appName = "IPPL";
  static const String appVersion = "1.0.0";
  static const String appVersionDisplay = "20211005 ";
  static const String allRightReserved = "Delhi";

  static const String _ANDROID = "ANDROID";
  static const String _IOS = "IOS";

  static String getPlatform() =>
      defaultTargetPlatform == TargetPlatform.android ? _ANDROID : _IOS;
}
