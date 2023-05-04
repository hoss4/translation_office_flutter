import 'dart:convert';
import 'package:translation_office_flutter/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:translation_office_flutter/models/client.dart';
import 'package:translation_office_flutter/models/translation_request.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class ClientApi {
  static const String BASE_URL = "/api/client/";

  static Future<String> getclient() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getclient";
    print("-------------------  sending request");
    var url = Uri.http(config.apiURL, url2);

    var response = await http.post(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<Map> updateclient(Client client) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}updateclient";
    var url = Uri.http(config.apiURL, url2);

    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'email': client.email,
          'username': client.username,
          'name': client.name,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        print('Could not update client');
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print(e.toString());
      var data = {"status": "error", "message": e.toString()};
      return data;
    }
  }

  static Future<Map> resetpass(String password, String newpass) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    print(loginDetails!.data!.token);
    var url2 = "${BASE_URL}resetpassword";
    var url = Uri.http(config.apiURL, url2);
    print(password + " " + newpass);

    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'password': password,
          'newpass': newpass,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      var data = {"status": "error", "message": e.toString()};
      return data;
    }
  }

  static Future<Map> create_req(TranslationRequest request) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}requesttrans";
    var url = Uri.http(config.apiURL, url2);

    try {
      var response = await http.post(url,
          headers: requestHeaders, body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        debugPrint('Could not create Request');
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      debugPrint(e.toString());
      var data = {"status": "error", "message": e.toString()};
      return data;
    }
  }

  static Future<List<dynamic>> getRequestedTranslations() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getreq";
    var url = Uri.http(config.apiURL, url2);
    try {
      var response = await http.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      } else {
        debugPrint('Could not get Requests');
        return [];
      }
    } catch (e) {
      print("here");
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Map> deleteTranslationRequest(id) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}deleteReq";
    var url = Uri.http(config.apiURL, url2);
    print(id);
    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'requestid': id,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        debugPrint('Could not delete Requests');
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      debugPrint(e.toString());
      var data = {"status": "error", "message": e.toString()};
      return data;
    }
  }
}
