import 'package:boochat_ui/src/common/auth_bloc/auth_bloc.dart';
import 'package:boochat_ui/src/common/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../data/data.dart';

class RoomItemBubble extends StatelessWidget {
  const RoomItemBubble({required this.roomItem, Key? key}) : super(key: key);
  final RoomItem roomItem;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    if (roomItem is Message) {
      final message = roomItem as Message;
      if (_messageIsSent(user, message)) {
        return SentMessageBubble(message: message);
      } else {
        return ReceivedMessageBubble(message: message);
      }
    } else {
      return AnnouncementText(
        content: roomItem.content,
      );
    }
  }

  bool _messageIsSent(User user, Message message) {
    return message.sender.id == user.id;
  }
}

class SentMessageBubble extends StatelessWidget {
  final Message message;
  const SentMessageBubble({required this.message, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat('hh:mm').format(message.dateSent),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Text(
                    message.content,
                  )),
            ),
          ),
        ]);
  }
}

class ReceivedMessageBubble extends StatelessWidget {
  final Message message;
  ReceivedMessageBubble({required this.message, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final users = context.read<UsersBloc>().state.allUsers;
    final messageSender =
        users.firstWhere((user) => user.id == message.sender.id);

    if (messageSender.imageUrl == null) {
      throw Exception("did not find user image");
    }
    return Row(children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image:
                  CachedNetworkImageProvider(messageSender.imageUrl as String),
            )),
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Text(message.content)),
        ),
      ),
      const SizedBox(width: 15),
      Text(
        DateFormat('hh:mm').format(message.dateSent),
        style: Theme.of(context).textTheme.caption,
      ),
    ]);
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
