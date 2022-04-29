import 'package:boochat_ui/shared/user.dart';
import 'package:boochat_ui/shared/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  Auth({required this.child, Key? key}) : super(key: key);
  final Widget child;
  final _googleSignIn = GoogleSignIn(scopes: [
    'profile',
  ], clientId: dotenv.env['CLIENT_ID']);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _handleSignIn(),
      builder: (context, loginResponse) {
        if (!loginResponse.hasData) {
          return const Text('waiting to login..');
        } else {
          return Consumer<UserModel>(builder: (context, userModel, child) {
            final user = loginResponse.data as User;
            if (!userModel.isLoggedIn) {
              return FutureBuilder(
                future: userModel.login(user),
                builder: (context, userModel) {
                  if (userModel.connectionState == ConnectionState.done &&
                      userModel.hasData) {
                    return Container(
                      child: child,
                    );
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
  }

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
