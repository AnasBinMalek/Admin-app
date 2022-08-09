import 'dart:convert';

import 'package:admin_app/model/order_model.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomHttpRequest {
  static const String uri = "https://apihomechef.antapp.space/api";

  static SharedPreferences? sharedPreferences;

  static Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences!.getString("token")}",
    };
    print("user token is :${sharedPreferences!.getString('token')}");
    return header;
  }

  static Future<dynamic> fetchHomeData() async {
    String link = "${uri}/admin/all/orders";
    var responce =
        await http.get(Uri.parse(link), headers: await getHeaderWithToken());
    if (responce.statusCode == 200) {
      return responce.body;
    } else {
      print("Failed");
      showToast("Failed");
    }
  }
}
