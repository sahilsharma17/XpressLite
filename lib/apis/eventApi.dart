import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xpresslite/model/model.dart';

class EventApi {

  Future<List<EventData>> getEventData() async {
  try {
    final response = await get(
      Uri.parse("https://xpress.businesstowork.com/api/EventBanner/GetEventBannerList"),
      headers: <String, String>{
        "content-type": "application/json; charset=UTF-8"
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Data fetched successfully");
      final List<dynamic> data = jsonDecode(response.body)['data']; 
      List<EventData> eventData = data.map((item) => EventData.fromJson(item)).toList();
      return eventData;
    } else {
      debugPrint("Data fetching failed ${response.statusCode}");
      throw Exception("Failed to fetch data");
    }
  } catch (e) {
    debugPrint("Data fetching error: $e");
    throw Exception("Failed to fetch data: $e");
  }
}

}
