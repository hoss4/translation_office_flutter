import 'package:mongo_dart/mongo_dart.dart';

class Client {
  String? email;
  String? password;
  String? backupemail;
  String? name;

  Client({
    this.email,
    this.password,
    this.backupemail,
    this.name,
  });
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'backupemail': backupemail,
        'name': name,
      };
}
