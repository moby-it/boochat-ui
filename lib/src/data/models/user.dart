import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? imageUrl;
  const User({required this.id, this.name, this.email, this.imageUrl});
  const User.empty()
      : id = '',
        imageUrl = '',
        email = '',
        name = '';
  User.fromJson(dynamic json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        email = json['email'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'imageUrl': imageUrl, 'email': email};
  @override
  List<Object?> get props => [id, name, imageUrl];
}
