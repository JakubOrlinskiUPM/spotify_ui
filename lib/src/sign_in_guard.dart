import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';

class SignInGuard extends StatefulWidget {
  const SignInGuard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<SignInGuard> createState() => _SignInGuardState();
}

class _SignInGuardState extends State<SignInGuard> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        BlocProvider.of<DataBloc>(context).add(DataSetUser(user: user));
      }
    });

    signInWithGoogle(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      if (state.user == null) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                signInWithGoogle(false);
              },
              child: Text("Sign in with Google"),
            )
          ],
        );
      } else {
        return widget.child;
      }
    });
  }

  Future<UserCredential?> signInWithGoogle(bool silent) async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser;
    if (silent) {
      googleUser = await GoogleSignIn().signInSilently();
    } else {
      googleUser = await GoogleSignIn().signIn();
    }

    if (googleUser != null) {
      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential cred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (cred.user != null &&
          cred.additionalUserInfo != null &&
          cred.additionalUserInfo!.isNewUser) {
        var profile = cred.additionalUserInfo!.profile!;
        var map = {
          "name": cred.user!.displayName,
          "email": cred.user!.email,
          "first_name": profile.containsKey('given_name')
              ? cred.additionalUserInfo!.profile!['given_name']
              : null,
          "last_name": profile.containsKey('family_name')
              ? cred.additionalUserInfo!.profile!['family_name']
              : null,
          "image_path": "/images/" + cred.user!.uid
        };

        BlocProvider.of<DataBloc>(context).addNewUser(cred.user!.uid, map);
      }
    }
  }
}
