import 'dart:convert';
import 'package:translation_office_flutter/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:translation_office_flutter/models/client.dart';
import 'package:translation_office_flutter/models/translation_request.dart';
import 'package:translation_office_flutter/services/shared_service.dart';

class ClientApi {
  // ignore: constant_identifier_names
  static const String BASE_URL = "/api/client/";

  static Future<Map> getclient() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url2 = "${BASE_URL}getclient";
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

  static Future<Map> createreq(TranslationRequest request) async {
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
}
