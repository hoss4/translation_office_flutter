// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:translation_office_flutter/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:translation_office_flutter/models/admin.dart';
import 'package:translation_office_flutter/models/trans.dart';
import 'package:translation_office_flutter/services/shared_service.dart';
import '../models/register_request_model.dart';

class AdminApi {
  static const String BASE_URL = "/api/admin/";

  static Future<Map> getadmin() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getadmin";
    var url = Uri.http(config.apiURL, url2);
    var response = await http.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 403) {
      return {"status": "403", "data": "Token expired"};
    }
    if (response.statusCode == 200) {
      return {"status": "200", "data": response.body};
    } else {
      return {"status": "404", "data": "Invalid credentials"};
    }
  }

  static Future<Map> updateadmin(Admin admin) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}updateAdmin";
    var url = Uri.http(config.apiURL, url2);

    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'email': admin.email,
          'username': admin.username,
          'name': admin.name,
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

  static Future<Map> resetpass(String password, String newpass) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}resetpassword";
    var url = Uri.http(config.apiURL, url2);

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

  static Future<Map> createtranslator(RegisterRequestModel model) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}createTranslator";
    var url = Uri.http(config.apiURL, url2);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 400) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  static Future<Map> createadmin(RegisterRequestModel model) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}createAdmin";
    var url = Uri.http(config.apiURL, url2);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 400) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  static Future<List<dynamic>> getRequestedTranslations() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getrequests";
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
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<dynamic>> getTranslators(String from, String to) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}gettranslators";
    var url = Uri.http(config.apiURL, url2);
    var load = jsonEncode({"from": from, "to": to});
    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: load,
      );
      List<Trans> result = [];
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var i = 0; i < data.length; i++) {
          result.add(Trans(
            id: data[i]['id'],
            name: data[i]['name'],
          ));
        }

        return result;
      } else {
        debugPrint('Could not get translators');
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Map> assignTranslator(
      String translatorid, String translationid) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };

    var url2 = "${BASE_URL}AssignedRequest";
    var url = Uri.http(config.apiURL, url2);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"translatorid": translatorid, "translationid": translationid}),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 400) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  static Future<List<dynamic>> getupcomingTranslations() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getupcomingtranslations";
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
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<dynamic>> getpreviousTranslations() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getoldtranslations";
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
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Map> cancelAppointement(id) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}CancelApp";
    var url = Uri.http(config.apiURL, url2);
    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'translationid': id,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        debugPrint('Could not delete appointement');
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      debugPrint(e.toString());
      var data = {"status": "error", "message": e.toString()};
      return data;
    }
  }

  static Future<List<dynamic>> getAssignedRequests() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getAssignedRequests";
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
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Map> unassignRequest(String translationid) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}unassignrequest";
    var url = Uri.http(config.apiURL, url2);

    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({'translationid': translationid}),
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
}
