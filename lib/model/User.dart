class User {
  final int id;
  final String username;

  final String email;
  final String first_name;
  final String last_name;
  final String phone;
  final String avatar;
  final String address;
  final int role_id;

  User(
      {this.id,
      this.username,
      this.email,
      this.first_name,
      this.last_name,
      this.phone,
      this.avatar,
      this.address,
      this.role_id});

// It creates an Category from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      phone: json["phone"],
      avatar: json["avatar"],
      address: json["address"],
      email: json["email"],
      role_id: json["role_id"],
    );
  }
}
