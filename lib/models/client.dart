class Client {
  String? email;
  String? username;
  String? name;

  Client({
    this.email,
    this.username,
    this.name,
  });
  Map<String, dynamic> toJson() => {
        'email': email,
        'backupemail': username,
        'name': name,
      };
}
