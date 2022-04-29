import 'package:boochat_ui/auth.dart';
import 'package:boochat_ui/room-list/room_list.dart';
import 'package:boochat_ui/shared/user.dart';
import 'package:boochat_ui/shared/user_model.dart';
import 'package:boochat_ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
    create: (context) => UserModel(),
    child: BoochatApp(),
  ));
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
          return Auth(child: const RoomList());
        },
      ),
    );
  }
}
