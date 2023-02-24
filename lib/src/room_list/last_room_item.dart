import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_state.dart';
import 'package:boochat_ui/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';

class LastRoomItem extends StatelessWidget {
  final RoomItem roomItem;
  final bool hasUnreadMessage;
  const LastRoomItem(
      {required this.roomItem, required this.hasUnreadMessage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    return BlocBuilder<ActiveRoomBloc, ActiveRoomState>(
      builder: (context, state) => Text(
        roomItem.content,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: _hasUnreadStatus(state, currentUser)
                ? Colors.white
                : const Color.fromRGBO(176, 201, 231, 1),
            fontWeight: _hasUnreadStatus(state, currentUser)
                ? FontWeight.w800
                : FontWeight.normal),
      ),
    );
  }

  bool _hasUnreadStatus(ActiveRoomState state, User currentUser) {
    if (state is ActiveRoomSelectedState && state.room.id == roomItem.roomId) {
      return false;
    }
    if (roomItem is Announcement) {
      return hasUnreadMessage;
    } else {
      return hasUnreadMessage && (roomItem as Message).sender != currentUser;
    }
  }
}
