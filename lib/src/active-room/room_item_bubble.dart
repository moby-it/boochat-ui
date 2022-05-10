import 'package:boochat_ui/src/common/auth_bloc/auth_bloc.dart';
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
        children: [
          Text(
            DateFormat('hh:mm').format(message.dateSent),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Text(message.content)),
          ),
        ]);
  }
}

class ReceivedMessageBubble extends StatelessWidget {
  final Message message;
  const ReceivedMessageBubble({required this.message, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(message.content)),
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
