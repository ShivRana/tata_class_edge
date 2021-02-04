import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tata_classedge/db/db_provider.dart';
import 'package:tata_classedge/db/note_model.dart';

class NotesProviderModel extends ChangeNotifier {
  int _position = -1;
  bool showWidget = false;
  List<Notes> _notes;
  Notes noteAtTheMarkedPosition;
  bool isPlay = false;

  bool isWidgetShowing = false;

  getRemainingTime() => _position;

  Notes getNote() => noteAtTheMarkedPosition;

  updatePosition(int position) {
    // _position = position;
    print("ShivVideo isWidgetShowing false");

    if (position != _position) {
      for (int i = 0; i < _notes.length; i++) {
        if (position == _notes[i].notePosition) {
          _position = position;
          print("ShivVideo ${_position}");
          isWidgetShowing = true;
          showWidget = true;
          noteAtTheMarkedPosition = _notes[i];
          startTimer();
          notifyListeners();
          break;
        }
      }
    }
  }

  void setNotesFromDb(List<Notes> notes) {
    this._notes = notes;
  }

  void refreshDb() async {
    _notes = await DBProvider.db.getAllNotes();
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 5), () {
      print("ShivVideo isWidgetShowing false");
      isWidgetShowing = false;
      showWidget = false;
      notifyListeners();
    });
  }

  void updatePlayPause(bool isPlay) {
    this.isPlay = isPlay;
    notifyListeners();
  }

  void updateShowWidget(bool showing) {
    showWidget = false;
    notifyListeners();
    isWidgetShowing = false;
    print("ShivVideo isWidgetShowing false");
    // notifyListeners();
  }
}
