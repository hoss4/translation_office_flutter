class Translator {
  String? email;
  String? username;
  String? name;

  Translator({
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
