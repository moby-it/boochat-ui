import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import './models/models.dart';

class RoomRepository {
  RoomRepository();

  final queryUri = dotenv.env["QUERY_URI"];
  Future<Room> fetchRoom(String roomId, String token) async {
    final response = await http.get(Uri.parse("$queryUri/rooms/getOne/$roomId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    final json = jsonDecode(response.body);
    return Room.fromJson(json);
  }
}
