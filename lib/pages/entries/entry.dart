import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  static const String kCreatedAt = 'createdAt';
  static const String kValue = 'value';
  static const String kMeaning = 'meaning';

  final DateTime createdAt;
  final String value;
  final String meaning;

  Entry({
    required this.createdAt,
    required this.value,
    required this.meaning,
  });

  factory Entry.create(String entry, String meaning) {
    return Entry(
      createdAt: DateTime.now(),
      value: entry,
      meaning: meaning,
    );
  }

  factory Entry.fromJson(Map<String, dynamic> json) {
    var createdAt = json[kCreatedAt];
    return Entry(
      createdAt: _parseJsonTimestamp(createdAt),
      value: json[kValue],
      meaning: json[kMeaning],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCreatedAt: createdAt.toIso8601String(),
      kValue: value,
      kMeaning: meaning,
    };
  }
}

_parseJsonTimestamp(dynamic createdAt) {
  if (createdAt is String) {
    return DateTime.parse(createdAt);
  } else if (createdAt is Timestamp) {
    return createdAt.toDate();
  } else {
    return null;
  }
}