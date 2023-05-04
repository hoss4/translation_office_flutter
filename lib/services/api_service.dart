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

  static Future<Map> login(LoginRequestModel model) async {
    //new code
    Map res = {};

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
      //print(response.body);
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      // new code
      res = {"status": "true", "response": loginResponseJson(response.body)};
      return res;
      //return true;
    } else {
      // new code
      print("here-----");
      res = {"status": "false", "response": loginResponseJson(response.body)};

      return res;
      //return false;
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

    return registerResponseJson(response.body);
  }
}
