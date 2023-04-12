import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translation_office_flutter/config.dart';
import 'package:translation_office_flutter/models/login_request_model.dart';
import 'package:translation_office_flutter/models/login_response_model.dart';
import 'package:translation_office_flutter/models/register_request_model.dart';
import 'package:translation_office_flutter/models/register_response_model.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(config.apiURL, config.loginAPI);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      print(response.body);
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future<RegisterResponseModel> resgister(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(config.apiURL, config.registerAPI);
    ;
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    print("----" + response.body);
    return registerResponseJson(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(config.apiURL, config.userProfileAPI);

    var response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      print("hello---" + response.body);
      return response.body;
    } else {
      print("hello1---" + response.body);
      return "";
    }
  }
}
