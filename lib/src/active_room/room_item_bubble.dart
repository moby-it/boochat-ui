import 'package:boochat_ui/src/core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../data/data.dart';

const double userImageSize = kIsWeb ? 50 : 30;

class RoomItemBubble extends StatelessWidget {
  const RoomItemBubble(
      {required this.roomItem, this.showUserImage = true, Key? key})
      : super(key: key);
  final bool showUserImage;
  final RoomItem roomItem;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    late final Widget bubble;
    if (roomItem is Message) {
      final message = roomItem as Message;
      if (_messageIsSent(user, message)) {
        bubble = SentMessageBubble(
          message: message,
          showUserImage: showUserImage,
        );
      } else {
        bubble = ReceivedMessageBubble(
          message: message,
          showUserImage: showUserImage,
        );
      }
    } else {
      bubble = AnnouncementText(
        content: roomItem.content,
      );
    }
    if (showUserImage) {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: bubble,
      );
    } else {
      return bubble;
    }
  }

  bool _messageIsSent(User user, Message message) {
    return message.sender.id == user.id;
  }
}

class SentMessageBubble extends StatelessWidget {
  final Message message;
  final bool showUserImage;
  const SentMessageBubble(
      {required this.message, required this.showUserImage, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.centerRight,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('hh:mm').format(message.dateSent),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Text(
                    message.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            showUserImage
                ? Container(
                    width: userImageSize,
                    height: userImageSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              currentUser.imageUrl as String,
                              cacheKey: currentUser.imageUrl),
                        )),
                  )
                : const SizedBox(
                    width: userImageSize,
                    height: userImageSize,
                  ),
          ]),
    );
  }
}

class ReceivedMessageBubble extends StatelessWidget {
  final Message message;
  final bool showUserImage;

  const ReceivedMessageBubble(
      {required this.message, required this.showUserImage, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final users = context.read<UsersBloc>().state.allUsers;
    final messageSender =
        users.firstWhere((user) => user.id == message.sender.id);
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.centerLeft,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        showUserImage
            ? Container(
                width: userImageSize,
                height: userImageSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        messageSender.imageUrl as String,
                        cacheKey: messageSender.imageUrl,
                      ),
                    )),
              )
            : const SizedBox(
                width: userImageSize,
                height: userImageSize,
              ),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Text(
                message.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          DateFormat('hh:mm').format(message.dateSent),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(width: 12),
      ]),
    );
  }
}

class AnnouncementText extends StatelessWidget {
  final String content;
  const AnnouncementText({required this.content, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 14, top: 24),
        child: Center(child: Text(content)));
  }
}
