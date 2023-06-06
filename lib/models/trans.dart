import 'dart:convert';

// ignore: non_constant_identifier_names
Trans TransJson(String str) => Trans.fromJson(json.decode(str));

class Trans {
  String? id;
  String? name;

  Trans({
    this.id,
    this.name,
  });

  Trans.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trans &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
