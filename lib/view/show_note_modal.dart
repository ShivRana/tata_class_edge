import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tata_classedge/db/db_provider.dart';
import 'package:tata_classedge/db/note_model.dart';
import 'package:tata_classedge/util/const.dart';
import 'package:tata_classedge/util/utils.dart';

typedef NoteCallback = int Function(int);

class ShowNoteModal extends StatefulWidget {
  NoteCallback noteCallback;

  int videoId;

  int videoPosition;

  String topic;

  String noteToShow;

  ShowNoteModal(this.topic, this.noteToShow, this.noteCallback);

  @override
  _NoteInputModal createState() => _NoteInputModal();
}

class _NoteInputModal extends State<ShowNoteModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () =>
                  {widget.noteCallback(Const.NOTE_CUT), Navigator.pop(context)},
              icon: Icon(
                Icons.clear,
                size: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 0, left: 40, right: 40),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  widget.topic,
                  style: TextStyle(
                      fontSize: 20, fontFamily: "bold", color: Colors.red),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  widget.noteToShow,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    color: Colors.red,
                    onPressed: () => {
                      widget.noteCallback(Const.NOTE_CUT),
                      Navigator.of(context).pop(),
                    },
                    child: Text(
                      "DISMISS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  saveNote(int videoPosition, String inputNote, int videoId) {
    if (inputNote.isEmpty) {
      Utils.showToast("Please type your note");
    } else {
      addNote(videoPosition, inputNote, videoId);
    }
  }

  addNote(int videoPosition, String inputNote, int videoId) async {
    var note = Notes(
        noteId: videoId.toString(),
        notePosition: videoPosition,
        notes: inputNote.toString());
    await DBProvider.db.newNote(note);
    Utils.showToast("Note saved successfully");
    widget.noteCallback(Const.NOTE_CUT);
    Navigator.of(context).pop();
  }
}
