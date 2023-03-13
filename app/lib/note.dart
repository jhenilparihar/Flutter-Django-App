import 'dart:convert';

class Note {
  int id;
  String note;
  Note({
    required this.id,
    required this.note,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': note,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      note: map['body'],
    );
  }
}
