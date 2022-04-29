class User {
  late String id;
  late String? name;
  late String? imageUrl;
  User({required this.id, required this.name, required this.imageUrl});
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'imageUrl': imageUrl};
}

class AuthResponse {
  late String token;
  late User user;
  AuthResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = User.fromJson(json['user']);
}
