import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../helper/app_utilities/method_utils.dart';
import '../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../helper/localStorage/preference_handler.dart';
import '../helper/routeAndBlocManager/navigator.dart';
import '../main.dart';
import 'app_mailer.dart';

class NetworkRequest {
  Map<String, dynamic> errorResp = {
    "status": false,
    "msg": "unable to communicate with server",
    "data": null
  };

  Future<Map<String, dynamic>> networkCallPostMap2(
    String url,
    Map<String, dynamic> parameter, {
    bool tokenAccess = false,
  }) async {
    int statusCode = 0;
    try {
      String jsonString = json.encode(parameter);
      String token = "Bearer ${await PreferenceHandler.getLoginToken()}";

      debugPrint("$jsonString");
      List<int> bodyBytes = utf8.encode(jsonString);
      HttpClient _httpClient = HttpClient();
      HttpClientRequest request = await _httpClient.postUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json');

      tokenAccess
          ? request.headers.set('Authorization', token)
          : debugPrint("");
      request.headers.set('Content-Length', bodyBytes.length.toString());
      request.add(bodyBytes);
      var resp = await request.close();
      statusCode = resp.statusCode;
      var responseBody = await resp.transform(utf8.decoder).join();
      debugPrint(" API: RESP: Url: $url => : $responseBody");

      if (resp.statusCode == 200) {
        return json.decode(responseBody);
      } else if (resp.statusCode == 401) {
        MethodUtils.showSessionTimeoutDialog(
          navigatorKey.currentContext!,
        );
      } else {
        openScreenAfterLogin(
            AccessDeniedScreen(
              msg: "${resp.statusCode} \n\n Server Down ",
              onPressed: () {
                // openScreenAfterLogin(DashboardScreen());
              },
            ));
      }
    } catch (e) {
      ErrorEmailer().sendMailOnCatchError(
        response: e.toString(),
        parameterSET: parameter,
        finalUrl2Hit: url,
        apiClientPreference: "Setrans",
        statusCode: statusCode,
      );
      debugPrint("url:$url ERROR IN API CALL: $e");
    }
    return errorResp;
  }

  Future<Map<String, dynamic>> networkCallPutMap(
    String url,
    Map<String, dynamic> parameter, {
    bool accessToken = false,
  }) async {
    try {
      String jsonString = json.encode(parameter);
      String token = "Bearer ${await PreferenceHandler.getLoginToken()}";
      debugPrint("=>$jsonString");
      List<int> bodyBytes = utf8.encode(jsonString);
      HttpClient _httpClient = HttpClient();
      HttpClientRequest request = await _httpClient.putUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json');
      accessToken
          ? request.headers.set('Authorization', token)
          : debugPrint("");
      request.headers.set('Content-Length', bodyBytes.length.toString());
      request.add(bodyBytes);
      var resp = await request.close();
      var responseBody = await resp.transform(utf8.decoder).join();
      debugPrint(" API: RESP: Url: $url => : $responseBody");

      if (resp.statusCode == 200) {
        return json.decode(responseBody);
      } else if (resp.statusCode == 401) {
        MethodUtils.showSessionTimeoutDialog(
          navigatorKey.currentContext!,
        );
      } else {
        openScreenAfterLogin(

            AccessDeniedScreen(
              msg: "${resp.statusCode} \n Server Down ",
              onPressed: () {
                // openScreenAfterLogin(
                //     DashboardScreen());
              },
            ));
      }
    } catch (e) {
      debugPrint("url:$url ERROR IN API CALL: $e");
    }
    return errorResp;
  }

  Future<Map<String, dynamic>> networkCallDelete(
    String url, {
    required Map<String, dynamic> parameter,
    bool accessToken = false,
  }) async {
    try {
      String token = "Bearer ${await PreferenceHandler.getLoginToken()}";
      String jsonString = json.encode(parameter);
      List<int> bodyBytes = utf8.encode(jsonString);
      HttpClient _httpClient = HttpClient();
      HttpClientRequest request = await _httpClient.deleteUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json');
      accessToken
          ? request.headers.set('Authorization', token)
          : debugPrint("");
      request.add(bodyBytes);
      var resp = await request.close();
      var responseBody = await resp.transform(utf8.decoder).join();
      debugPrint(" API: RESP: Url: $url => : $responseBody");

      if (resp.statusCode == 200) {
        return json.decode(responseBody);
      } else if (resp.statusCode == 401) {
        MethodUtils.showSessionTimeoutDialog(
         navigatorKey.currentContext!
        );
      } else {
        openScreenAfterLogin(

            AccessDeniedScreen(
              msg: "${resp.statusCode} \n\n Server Down ",
              onPressed: () {
                // openScreenAfterLogin(
                //     DashboardScreen());
              },
            ));
      }
    } catch (e) {
      debugPrint("url:$url ERROR IN API CALL: $e");
    }
    return errorResp;
  }

  Future<Map<String, dynamic>> networkCallGetMap(
    String _url, {
    bool accessToken = false,
  }) async {
    try {
      HttpClient _httpClient = new HttpClient();

      debugPrint("URL->$_url");
      String token = "Bearer ${await PreferenceHandler.getLoginToken()}";

      HttpClientRequest request = await _httpClient.getUrl(Uri.parse(_url));
      accessToken
          ? request.headers.set('Authorization', token)
          : debugPrint("");

      var resp = await request.close();
      print("status code ${resp.statusCode}");
      var responseBody = await resp.transform(utf8.decoder).join();

      debugPrint(" => : $responseBody");

      if (resp.statusCode == 200) {
        return json.decode(responseBody);
      } else if (resp.statusCode == 401) {
        MethodUtils.showSessionTimeoutDialog(
            navigatorKey.currentContext!
        );
      } else {
        openScreenAfterLogin(

            AccessDeniedScreen(
              msg: "${resp.statusCode} \n\n Server Down ",
              onPressed: () {
                // openScreenAfterLogin(
                //     DashboardScreen());
              },
            ));
      }
    } catch (e) {
      debugPrint("error is $e");
      debugPrint("error is $e");
    }
    return errorResp;
  }

  Future<Map<String, dynamic>> uploadFile(
    String _destinationURL,
    String _fileLocalPath,
  ) async {
    var postUri = Uri.parse(_destinationURL);
    String token = "Bearer ${await PreferenceHandler.getLoginToken()}";
    var request = new http.MultipartRequest("POST", postUri);
    Map<String, String> mapHeader = {
      "Authorization": token,
    };

    request.files.add(await http.MultipartFile.fromPath(
      'ProfileImage', //fileKey
      _fileLocalPath,
      contentType: new MediaType('image', 'jpg'),
    ));
    request.headers.addAll(mapHeader);
    StreamedResponse resp = await request.send();
    Map<String, dynamic> successResp =
        json.decode(await resp.stream.bytesToString());

    return resp.statusCode == 200 ? successResp : errorResp;
  }

  String getErrorHTMLBody(
          {required String targetURL, var varPrameter, var errorData}) =>
      "<p>URL : ${targetURL},"
      "<br/> PARAMETER : ${varPrameter.toString()} "
      "<br/> ERROR TRACE : $errorData</p>";
}
