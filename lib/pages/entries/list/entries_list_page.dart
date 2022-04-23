import 'package:app/pages/entries/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class EntriesListPage extends StatelessWidget {
  EntriesListPage({Key? key}) : super(key: key);

  final entriesQuery = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('buckets')
      .doc('english')
      .collection('entries')
      .orderBy('created_at', descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => Entry.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FirestoreListView<Entry>(
        query: entriesQuery,
        itemBuilder: (context, snapshot) {
          var entry = snapshot.data();

          return Card(
            child: ListTile(
              title: Text(entry.value),
              subtitle: Text(entry.createdAt.toString()),
            ),
          );
        },
      ),
    );
  }
}
