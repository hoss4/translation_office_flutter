class TranslationRequest {
  String? fromlanguage;
  String? tolanguage;
  bool? onthephone;
  bool? inperson;
  DateTime? date;

  TranslationRequest({
    this.fromlanguage,
    this.tolanguage,
    this.onthephone,
    this.inperson,
    this.date,
  });

  TranslationRequest.fromJson(Map<String, dynamic> json) {
    fromlanguage = json['fromlanguage'];
    tolanguage = json['tolanguage'];
    onthephone = json['onthephone'];
    inperson = json['inperson'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromlanguage'] = fromlanguage;
    data['tolanguage'] = tolanguage;
    data['onthephone'] = onthephone;
    data['inperson'] = inperson;
    data['date'] = date!.toIso8601String();
    return data;
  }
}
