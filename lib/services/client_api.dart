import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:translation_office_flutter/models/client.dart';

class ClientApi {
  static const String BASE_URL = "http://172.20.10.7/api/client";

  static create_client(Client client) async {
    //print(client.toJson());

    var url = Uri.parse(BASE_URL + "/createclient");
    try {
      var response = await http.post(url, body: client.toJson());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print(data.toString());
      } else {
        debugPrint('Could not create client');
      }
    } catch (e) {
      //print('here');
      debugPrint(e.toString());
    }
  }

  static get_client(String email, String password) async {
    var url = Uri.parse(BASE_URL + "/getclient");
    try {
      //print("front" + email + password);
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data.toString());
        return data;
      } else {
        debugPrint('Could not get client');
      }
    } catch (e) {
      //print('here');
      debugPrint(e.toString());
    }
  }

  static update_client(id, Client client) async {
    var url = Uri.parse(BASE_URL + "/updateclient/$id");

    print("$BASE_URL/updateclient/$id");
    try {
      var response = await http.post(url, body: {
        'email': client.email,
        'password': client.password,
        'backupemail': client.backupemail,
        'name': client.name,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data.toString());
      } else {
        print('Could not update client');
      }
    } catch (e) {
      print('here4');
      print(e.toString());
    }
  }

  static create_req(id, Map data) async {
    var url = Uri.parse(BASE_URL + "/requesttrans/$id");
    try {
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print(data.toString());
      } else {
        debugPrint('Could not create client');
      }
    } catch (e) {
      //print('here');
      debugPrint(e.toString());
    }
  }
}
