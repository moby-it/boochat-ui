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
          return FutureBuilder(
            future: _handleSignIn(),
            builder: (context, loginResponse) {
              if (!loginResponse.hasData) {
                return const Text('waiting to login..');
              } else {
                return Consumer<UserModel>(
                    builder: (context, userModel, child) {
                  final user = loginResponse.data as User;
                  if (!userModel.isLoggedIn) {
                    return FutureBuilder(
                      future: userModel.login(user),
                      builder: (context, userModel) {
                        if (userModel.connectionState == ConnectionState.done &&
                            userModel.hasData) {
                          return const Text('logged in succesfull');
                        } else if (userModel.hasError) {
                          return Text(userModel.error.toString());
                        } else {
                          return const Text('loading...');
                        }
                      },
                    );
                  } else {
                    return const Text('loggedIn');
                  }
                });
              }
            },
          );
        },
      ),
    );
  }

  final _googleSignIn = GoogleSignIn(scopes: [
    'profile',
  ], clientId: dotenv.env['CLIENT_ID']);

  Future<User?> _handleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) throw Exception('account not found');
      return User(
          id: account.id,
          imageUrl: account.photoUrl,
          name: account.displayName);
    } catch (error) {
      print(error);
    }
  }
}
