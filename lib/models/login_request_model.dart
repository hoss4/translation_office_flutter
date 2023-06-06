// ignore_for_file: no_leading_underscores_for_local_identifiers

class LoginRequestModel {
  LoginRequestModel({
    this.username,
    this.password,
  });
  late final String? username;
  late final String? password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    return _data;
  }
}
