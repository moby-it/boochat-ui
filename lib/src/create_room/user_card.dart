import 'package:flutter/cupertino.dart';

import '../data/data.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(user.name ?? "No username");
  }
}
