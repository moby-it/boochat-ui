import 'dart:convert';
import 'dart:io';

import 'package:boochat_ui/src/active-room/room_item_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../providers/providers.dart';

class ActiveRoomArgumentsScreen extends StatelessWidget {
  ActiveRoomArgumentsScreen({Key? key}) : super(key: key);
  final queryUri = dotenv.env["QUERY_URI"];
  static const routeName = '/rooms';

  @override
  Widget build(BuildContext context) {
    final room = ModalRoute.of(context)!.settings.arguments as Room;
    if (queryUri == null) {
      throw Exception("cannot fetch room with no query uri");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: FutureBuilder(
        future: fetchRoom(room.id,
            context.select((AuthProvider userProvider) => userProvider.token)),
        builder: (context, AsyncSnapshot<Room> snapshot) {
          if (snapshot.hasData) {
            final Room room = snapshot.data as Room;
            return ListView.builder(
                itemCount: room.items.length,
                itemBuilder: (context, index) =>
                    RoomItemBubble(roomItem: room.items[index]));
          } else {
            return const Text("loading room data");
          }
        },
      ),
    );
  }

  Future<Room> fetchRoom(String roomId, String token) async {
    final response = await http.get(Uri.parse("$queryUri/rooms/getOne/$roomId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    final json = jsonDecode(response.body);
    return Room.fromJson(json);
  }
}
