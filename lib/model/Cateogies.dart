class Category {
  final int id;
  final String hinhanh, ten, mota, created_at, updated_at;

  Category(
      {this.hinhanh,
      this.ten,
      this.mota,
      this.created_at,
      this.updated_at,
      this.id});

  // It creates an Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      hinhanh: json["hinhanh"],
      ten: json["ten"],
      mota: json["mota"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}
