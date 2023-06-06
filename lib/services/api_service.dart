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
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      res = {"status": "true", "response": loginResponseJson(response.body)};
      return res;
    } else {
      res = {"status": "false", "response": loginResponseJson(response.body)};

      return res;
    }
  }

  static Future<RegisterResponseModel> resgister(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(config.apiURL, config.registerAPI);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }

  static Future<Map> resetpassword(String username, String email) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var load = {"username": username, "email": email};
    var url = Uri.http(config.apiURL, config.resetAPI);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(load),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<Map> confirmpin(String pin, String email, String type) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var load = {"code": pin, "email": email, "type": type};
    var url = Uri.http(config.apiURL, config.checkcode);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(load),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<Map> changepassword(
      String password, String email, String type) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var load = {"password": password, "email": email, "type": type};
    var url = Uri.http(config.apiURL, config.changepassword);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(load),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}
