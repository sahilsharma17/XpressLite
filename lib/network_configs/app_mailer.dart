import 'dart:convert';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../helper/app_utilities/date_utils.dart';
import '../helper/constant/apiUrls.dart';

class AppMailer {
  static String getCubitErrorHTMLBody({required String pageCode, required String apiUrl, required String errorDispMsg, required Map<String, dynamic> param}) => """<html>
<body>
<div style="border: 1px solid red; padding: 25px 50px; background-color: snow;">
  <h1 style="color:darkred;">       ERROR TRACE Setrans ${AppDateUtils.getFormattedDate(now: DateTime.now())}      <h1/>
  <br/>
    <p>PAGE CODE : <strong>$pageCode</strong></p>
      <p><strong>ApiUrl </strong></p>
      <p>$apiUrl</p>
      <hr>
       <p><strong>DISPLAY MESSAGE</strong> </p>
        <p>$errorDispMsg</p>
        <hr>
      <p><strong>PARAMETER DETAIL</strong></p>
      <p>${jsonEncode(param)}</p>
      </div>
      </body>
      </html>
  """;

  static String getErrorHTMLBody({required String targetURL, required Map<String, dynamic> headers, required Map<String, dynamic> parameters, required String errorData}) => """<html>
<body>
<div style="border: 1px solid red; padding: 25px 50px; background-color: snow;">
  <h1 style="color:darkred;">       ERROR TRACE Setrans  ${AppDateUtils.getFormattedDate(now: DateTime.now())}      <h1/>
  <br/>
    <p>URL : <strong>$targetURL</strong></p>
      <p><strong>HEADER USED</strong></p>
      <p>${jsonEncode(headers)}</p>
      <hr>
       <p><strong>PARAMETER USED</strong> </p>
        <p>${jsonEncode(parameters)} </p>
        <hr>
      <p><strong>API RESPONSE</strong></p>
      <p>${jsonEncode(errorData)}</p>
      </div>
      </body>
      </html>
  """;

  static void sendMail({String? targetEmail, String? mailSubject, String? mailBody, String htmlBody = ""}) async {
    String username = AppAuth.appMailerEmail;
    String password = AppAuth.appMailerPassword;

    username = AppAuth.appMailerEmail;
    password = AppAuth.appMailerPassword;
    // final smtpServer = gmail(username, password);
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Setrans trace')
      ..recipients.add(AppAuth.appTraceReceiverEmail)
//      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = mailSubject
      ..text = mailBody
      ..html = htmlBody;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent1. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
  }
}

class ErrorEmailer {
  void sendMailOnError({required String finalUrl2Hit, required Map<String, dynamic> headers, required Map<String, dynamic> parameterSET, Map<String, dynamic>? response, required String companyCode, required String targetURL, required int statusCode, required String apiClientPreference}) {
    String htmlRaw = AppMailer.getErrorHTMLBody(
      targetURL: finalUrl2Hit,
      headers: headers,
      parameters: parameterSET,
      errorData: "$response",
    );


      AppMailer.sendMail(targetEmail: AppAuth.appTraceReceiverEmail, mailSubject: "($apiClientPreference)=> Setran-ERROR IN $companyCode At: ${targetURL.split("/").last}", mailBody: "NETWORK STATUS CODE : $statusCode", htmlBody: htmlRaw);

  }
  void sendMailOnCatchError({required String finalUrl2Hit, required Map<String, dynamic> parameterSET, required String response,  required int statusCode, required String apiClientPreference}) {
    String htmlRaw = AppMailer.getCubitErrorHTMLBody(pageCode: "", errorDispMsg: response, param: parameterSET, apiUrl: finalUrl2Hit);
    AppMailer.sendMail(targetEmail: AppAuth.appTraceReceiverEmail, mailSubject: "($apiClientPreference)=> Setran-ERROR IN  At: ${finalUrl2Hit.split("/").last}", mailBody: "NETWORK STATUS CODE : $statusCode", htmlBody: htmlRaw);
  }
}

class AppMailer2 {
  static String getErrorHTMLBody(
      {required String targetURL,
        var varPrameter,
        var errorData,
        required String deviceName}) =>
      "<p> DEVICE INFO : ${deviceName}"
          "<br/> URL : ${targetURL}"
          "<br/> PARAMETER : ${varPrameter.toString()} "
          "<br/> ERROR TRACE : ${errorData}</p>";

  static void sendMail(
      {
        required String mailSubject,
        String htmlBody = ""}) async {

    String username = AppAuth.appMailerEmail;
    String password = AppAuth.appMailerPassword;


    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'jatin verma')
      ..recipients.add(AppAuth.appTraceReceiverEmail)
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent2. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

//     final smtpServer = gmail(username, password);
//     // Use the SmtpServer class to configure an SMTP server:
//     // final smtpServer = SmtpServer('smtp.domain.com');
//     // See the named arguments of SmtpServer for further configuration
//     // options.
//
//     // Create our message.
//     final message = Message()
//       ..from = Address(username, 'jatin verma')
//       ..recipients.add( AppAuth.appTraceReceiverEmail)
// //      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
// //      ..bccRecipients.add(Address('bccAddress@example.com'))
//       ..subject = mailSubject
//       ..text = getErrorHTMLBody as String?
//       ..html = htmlBody;
//
//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent.');
//       for (var p in e.problems) {
//         print('Problem: ${p.code}: ${p.msg}');
//       }
//     }
    // DONE
  }
}
