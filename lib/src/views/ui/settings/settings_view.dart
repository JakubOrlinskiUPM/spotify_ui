import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_ui/src/app.dart';
import 'package:spotify_ui/src/data/dummy_data/main.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const OutlinedButton(
                onPressed: syncDummySongs,
                child: Text("Sync songs"),
              ),
              const OutlinedButton(
                onPressed: syncDummyPlaylists,
                child: const Text("Sync playlists"),
              ),
              const OutlinedButton(
                onPressed: syncDummyAlbums,
                child: Text("Sync albums"),
              ),
              const OutlinedButton(
                onPressed: syncDummyAuthors,
                child: Text("Sync authors"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    GoogleSignIn().signOut();
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text("Logout"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
