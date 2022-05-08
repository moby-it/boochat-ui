import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? imageUrl;
  const User({required this.id, this.name, this.imageUrl});
  const User.empty()
      : id = '',
        imageUrl = '',
        name = '';
  User.fromJson(dynamic json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'imageUrl': imageUrl};
  @override
  List<Object?> get props => [id, name, imageUrl];
}
