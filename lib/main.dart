import 'package:boochat_ui/room-list/room_list.dart';
import 'package:boochat_ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(BoochatApp());
}

class BoochatApp extends StatelessWidget {
  BoochatApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BoochatTheme.themeData(context),
      child: WidgetsApp(
        title: 'Boochat UI',
        color: Theme.of(context).primaryColor,
        builder: (context, navigator) {
          return FutureBuilder(
            future: _handleSignIn(),
            builder: (context, data) {
              return Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
                  child: const RoomList());
            },
          );
        },
      ),
    );
  }

  final _googleSignIn = GoogleSignIn(scopes: [
    'profile',
  ]);
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
