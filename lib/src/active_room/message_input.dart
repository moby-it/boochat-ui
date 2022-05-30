import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({Key? key}) : super(key: key);
  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (String value) {
                    if (value.isNotEmpty) {
                      context
                          .read<ActiveRoomBloc>()
                          .add(SendMessageEvent(value));
                      controller.clear();
                    }
                  },
                  decoration: InputDecoration(
                    hoverColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    hintText: 'Type your message',
                    hintStyle: Theme.of(context).textTheme.labelMedium?.merge(
                        const TextStyle(
                            color: Color.fromRGBO(149, 174, 203, 1))),
                    suffix: GestureDetector(
                      onTap: () {
                        if (controller.text.isNotEmpty) {
                          context
                              .read<ActiveRoomBloc>()
                              .add(SendMessageEvent(controller.text));
                          controller.clear();
                        }
                      },
                      child: const Icon(
                        Icons.send_outlined,
                        color: Color.fromRGBO(176, 201, 231, 1),
                        size: 18,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
