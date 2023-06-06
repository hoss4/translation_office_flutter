// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:translation_office_flutter/config.dart';
import 'package:http/http.dart' as http;
import 'package:translation_office_flutter/models/translator.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class TranslatorApi {
  static const String BASE_URL = "/api/translator/";

  static Future<Map> gettranslator() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}gettranslator";
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

  static Future<Map> updatetranslator(Translator translator) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}updateTranslator";
    var url = Uri.http(config.apiURL, url2);

    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'email': translator.email,
          'username': translator.username,
          'name': translator.name,
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

  static Future<List<dynamic>> getRequestedTranslations() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}gettranslationrequests";
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
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<Map> acceptRequest(String translationid) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}acceptrequest";
    var url = Uri.http(config.apiURL, url2);
    debugPrint("accept request");
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

  static Future<Map> rejectRequest(String translationid) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}rejectrequest";
    var url = Uri.http(config.apiURL, url2);
    debugPrint("reject request");
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
    var url2 = "${BASE_URL}cancelrequest";
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

  static Future<Map> addlanguage(String language) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}addlanguage";
    var url = Uri.http(config.apiURL, url2);
    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({'language': language}),
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

  static Future<Map> removelanguage(String language) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}removelanguage";
    var url = Uri.http(config.apiURL, url2);
    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({'language': language}),
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
