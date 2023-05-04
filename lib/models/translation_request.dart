import 'package:mongo_dart/mongo_dart.dart';

class TranslationRequest {
  String? fromlanguage;
  String? tolanguage;
  bool? onthephone;
  bool? inperson;
  DateTime? date;
  DateTime? time;

  TranslationRequest(
      {this.fromlanguage,
      this.tolanguage,
      this.onthephone,
      this.inperson,
      this.date,
      this.time});

  TranslationRequest.fromJson(Map<String, dynamic> json) {
    fromlanguage = json['fromlanguage'];
    tolanguage = json['tolanguage'];
    onthephone = json['onthephone'];
    inperson = json['inperson'];
    date = DateTime.parse(json['date']);
    time = DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromlanguage'] = fromlanguage;
    data['tolanguage'] = tolanguage;
    data['onthephone'] = onthephone;
    data['inperson'] = inperson;
    data['date'] = date!.toIso8601String();
    data['time'] = time!.toIso8601String();
    return data;
  }
}
