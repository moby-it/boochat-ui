import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../data/data.dart';

class UserChip extends StatelessWidget {
  final User user;
  final VoidCallback deleteHandler;
  const UserChip({required this.user, required this.deleteHandler, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: Theme.of(context).cardColor,
        label: Row(
          children: [
            CachedNetworkImage(
              imageUrl: user.imageUrl!,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(user.name!)
          ],
        ),
        onDeleted: deleteHandler);
  }
}
