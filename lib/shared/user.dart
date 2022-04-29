class User {
  late String id;
  late String? name;
  late String? imageUrl;
  User({required this.id, required this.name, required this.imageUrl});
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        name = json['name'];
}
