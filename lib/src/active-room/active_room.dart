import 'dart:convert';
import 'dart:io';

import 'package:boochat_ui/src/active-room/room_item.dart';
import 'package:boochat_ui/src/data/room_model.dart';
import 'package:boochat_ui/src/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../shared/shared.dart';

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ActiveRoomArgumentsScreen extends StatelessWidget {
  ActiveRoomArgumentsScreen({Key? key}) : super(key: key);
  final queryUri = dotenv.env["QUERY_URI"];
  static const routeName = '/rooms';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final room = ModalRoute.of(context)!.settings.arguments as RoomModel;
    if (queryUri == null) {
      throw Exception("cannot fetch room with no query uri");
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(room.name),
        ),
        body: Consumer<AppUserModel>(
          builder: (context, userModel, child) => FutureBuilder(
            future: fetchRoom(room.id, userModel.token),
            builder: (context, AsyncSnapshot<RoomModel> snapshot) {
              if (snapshot.hasData) {
                final RoomModel room = snapshot.data as RoomModel;
                return ListView.builder(
                    itemCount: room.items.length,
                    itemBuilder: (context, index) =>
                        RoomItem(roomItem: room.items[index]));
              } else {
                return const Text("loading room data");
              }
            },
          ),
        ));
  }

  Future<RoomModel> fetchRoom(String roomId, String token) async {
    final response = await http.get(Uri.parse("$queryUri/rooms/getOne/$roomId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    final json = jsonDecode(response.body);
    return RoomModel.fromJson(json);
  }
}
