
class Account {
  String type;
  String name;

  Account({this.name, this.type});

  Account.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? null;
    name = json['name'] ?? null;
  }
  Map<String, dynamic> toJson() => {'type': type, 'name': name};
}