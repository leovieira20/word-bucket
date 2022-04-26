import 'package:app/pages/entries/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateEntryPage extends StatefulWidget {
  const CreateEntryPage({Key? key}) : super(key: key);

  @override
  State<CreateEntryPage> createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _entryController = TextEditingController();
  final _meaningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Entry'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _valueTextField(),
              _meaningTextField(),
              _submitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _valueTextField() {
    return TextFormField(
      controller: _entryController,
      decoration: const InputDecoration(
        labelText: 'Entry',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField _meaningTextField() {
    return TextFormField(
      controller: _meaningController,
      decoration: const InputDecoration(
        labelText: 'Description',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  ElevatedButton _submitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async => await _submitForm(context),
        child: const Text('Submit'));
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var entry = _entryController.text;
    var meaning = _meaningController.text;

    var newEntry = Entry.create(entry, meaning);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('buckets')
        .doc('english')
        .collection('entries')
        .add(newEntry.toJson());

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }
}
