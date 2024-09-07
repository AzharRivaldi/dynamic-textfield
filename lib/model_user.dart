class ModelListUser {
  String? first_name;
  String? last_name;
  String? avatar;
  String? email;

  ModelListUser({this.first_name, this.last_name, this.avatar, this.email});

  ModelListUser.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'].toString();
    last_name = json['last_name'].toString();
    avatar = json['avatar'].toString();
    email = json['email'].toString();
  }

  static List<ModelListUser> fromJsonList(List list) {
    if (list.length == 0) return List<ModelListUser>.empty();
    return list.map((item) => ModelListUser.fromJson(item)).toList();
  }

}