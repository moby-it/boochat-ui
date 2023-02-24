import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      width: 421,
      height: 64,
      padding: const EdgeInsets.all(8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CachedNetworkImage(imageUrl: user.imageUrl!),
        const SizedBox(
          width: 12,
        ),
        Text(
          user.name!,
          style: Theme.of(context).textTheme.labelMedium,
        )
      ]),
    );
  }
}
