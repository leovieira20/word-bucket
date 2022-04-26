import 'package:app/pages/entries/create/create_entry_page.dart';
import 'package:app/pages/entries/list/entries_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

const String kRootPage = '/';
const String kEntriesListRoute = '/entries/list';
const String kCreateEntryRoute = '/entries/create';
const String kUserProfileRoute = '/profile';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return MaterialApp(
      initialRoute: auth.currentUser == null ? kRootPage : kEntriesListRoute,
      routes: {
        kRootPage: (context) => _navigateToSignInScreen(),
        kUserProfileRoute: (context) => _navigateToProfileScreen(),
        kEntriesListRoute: (context) => EntriesListPage(),
        kCreateEntryRoute: (context) => CreateEntryPage(),
      },
    );
  }

  SignInScreen _navigateToSignInScreen() {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, kEntriesListRoute);
        }),
      ],
    );
  }

  ProfileScreen _navigateToProfileScreen() {
    return ProfileScreen(
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, kRootPage);
        }),
      ],
    );
  }
}