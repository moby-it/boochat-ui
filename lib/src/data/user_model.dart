class UserModel {
  late String id;
  late String? name;
  late String? imageUrl;
  UserModel({required this.id, required this.name, required this.imageUrl});
  UserModel.fromJson(dynamic json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'imageUrl': imageUrl};
}
