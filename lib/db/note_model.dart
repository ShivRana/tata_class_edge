import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  Notes({this.noteId, this.notePosition, this.notes});

  String noteId;
  int notePosition;
  String notes;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        noteId: json["note_id"],
        notePosition: json["note_position"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "note_id": noteId,
        "note_position": notePosition,
        "notes": notes,
      };
}
