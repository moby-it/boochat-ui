import 'package:boochat_ui/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleAuthProvider extends StatelessWidget {
  GoogleAuthProvider({required this.child, Key? key}) : super(key: key);
  final Widget child;
  final _googleSignIn = GoogleSignIn(scopes: [
    'profile',
  ], clientId: dotenv.env['CLIENT_ID']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _handleSignIn(),
        builder: (context, loginResponse) {
          if (!loginResponse.hasData) {
            return const Text('waiting to login..');
          } else {
            return Consumer<AppUserModel>(builder: (context, userModel, _) {
              final user = loginResponse.data as UserModel;
              if (!userModel.isLoggedIn) {
                return FutureBuilder(
                  future: userModel.login(user),
                  builder: (context, userModel) {
                    if (userModel.hasError) {
                      return Text(userModel.error.toString());
                    } else {
                      return const Text('loading...');
                    }
                  },
                );
              } else {
                return Container(
                  child: child,
                );
              }
            });
          }
        },
      ),
    );
  }

  Future<UserModel?> _handleSignIn() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) throw Exception('account not found');
      return UserModel(
          id: account.id,
          imageUrl: account.photoUrl,
          name: account.displayName);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
