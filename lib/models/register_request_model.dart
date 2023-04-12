class RegisterRequestModel {
  RegisterRequestModel({this.username, this.password, this.email, this.name});
  late final String? username;
  late final String? password;
  late final String? email;
  late final String? name;
  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    _data['name'] = name;

    return _data;
  }
}
