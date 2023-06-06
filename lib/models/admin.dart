class Admin {
  String? email;
  String? username;
  String? name;

  Admin({
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
