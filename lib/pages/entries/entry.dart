import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  final DateTime createdAt;
  final String value;

  Entry({
    required this.createdAt,
    required this.value,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      createdAt: (json['created_at'] as Timestamp).toDate(),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'value': value,
    };
  }
}