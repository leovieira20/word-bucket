import 'package:app/pages/entries/list/entries_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return MaterialApp(
      initialRoute: auth.currentUser == null ? '/' : '/entries',
      routes: {
        '/': (context) => _navigateToSignInScreen(),
        '/profile': (context) => _navigateToProfileScreen(),
        '/entries': (context) => EntriesListPage(),
      },
    );
  }

  SignInScreen _navigateToSignInScreen() {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, '/entries');
        }),
      ],
    );
  }

  ProfileScreen _navigateToProfileScreen() {
    return ProfileScreen(
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/');
        }),
      ],
    );
  }
}