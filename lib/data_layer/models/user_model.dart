class UserModel {
  String? name;
  String? email;
  List<Map<String, dynamic>> userCart = [];

  UserModel({this.name, this.email, required this.userCart});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userCart = json['userCart'];
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'userCart': userCart};
  }
}
