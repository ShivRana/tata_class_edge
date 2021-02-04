import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tata_classedge/db/db_provider.dart';
import 'package:tata_classedge/db/note_model.dart';
import 'package:tata_classedge/util/const.dart';
import 'package:tata_classedge/util/utils.dart';

typedef NoteCallback = int Function(int);

class NoteInputModal extends StatefulWidget {
  NoteCallback noteCallback;

  int videoId;

  int videoPosition;

  NoteInputModal(this.videoPosition, this.videoId, this.noteCallback);

  @override
  _NoteInputModal createState() => _NoteInputModal();
}

class _NoteInputModal extends State<NoteInputModal> {
  String inputNote;

  String hintString = "Type your note here..";
  var myTextEditingController = TextEditingController();

  var _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (!_focusNode.hasFocus) {
        setState(() {
          _focusNode = FocusNode();
        });
      }
    });
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
                  "Add a note",
                  style: TextStyle(
                      fontSize: 20, fontFamily: "bold", color: Colors.red),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  "Add a note to this point of the video",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 120,
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.all(10.0),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 120.0,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SizedBox(
                          height: 110.0,
                          child: TextField(
                            focusNode: _focusNode,
                            textAlign: TextAlign.start,
                            controller: myTextEditingController,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              hintText: hintString,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            showCursor: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (String newValue) {
                              inputNote = newValue;
                              myTextEditingController.value.copyWith(
                                  text: newValue,
                                  selection: TextSelection(
                                      baseOffset: newValue.length,
                                      extentOffset: newValue.length));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    color: Colors.red,
                    onPressed: () => {
                      {
                        saveNote(
                            widget.videoPosition, inputNote, widget.videoId)
                      }
                    },
                    child: Text(
                      "SUBMIT",
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
    widget.noteCallback(Const.NOTE_SUCCESSFUL);
    Navigator.of(context).pop();
  }
}
