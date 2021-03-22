import 'package:chocaycanh/model/User.dart';

class Myprofile {
  static int id;
  static String username;
  static String email;
  static String first_name;
  static String last_name;
  static String phone;
  static String avatar;
  static String address;
  static int role_id;
  Myprofile();
// It creates an Category from JSON
  factory Myprofile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    phone = json['phone'];
    avatar = json['avatar'];
    address = json['address'];
    role_id = json['role_id'];
    return Myprofile();
  }

  factory Myprofile.fromUser(User user) {
    id = user.id;
    username = user.username;
    email = user.email;
    first_name = user.first_name;
    last_name = user.last_name;
    phone = user.phone;
    avatar = user.avatar;
    address = user.address;
    role_id = user.role_id;

    return Myprofile();
  }
}
