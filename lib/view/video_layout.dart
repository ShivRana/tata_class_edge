import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tata_classedge/db/db_provider.dart';
import 'package:tata_classedge/db/note_model.dart';
import 'package:tata_classedge/provider/notes_provider_model.dart';
import 'package:tata_classedge/view/note_input_modal.dart';
import 'package:tata_classedge/view/quiz_layout.dart';
import 'package:tata_classedge/view/show_note_modal.dart';
import 'package:video_player/video_player.dart';

class VideoLayout extends StatefulWidget {
  int index;

  String topic;

  VideoLayout(this.index, this.topic);

  @override
  _VideoLayout createState() => _VideoLayout();
}

class _VideoLayout extends State<VideoLayout> with TickerProviderStateMixin {
  VideoPlayerController _controller;

  var _getNotesFromDb;

  @override
  void initState() {
    super.initState();
    _getNotesFromDb = getNotesPosition();
    _controller = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    _controller.initialize().then((_) {
      setState(() {
        _controller.play();
      });
    });
    _controller.addListener(() {
      videoListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set landscape orientation;
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return ChangeNotifierProvider<NotesProviderModel>(
      create: (context) => NotesProviderModel(),
      child: MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: Container(
                color: Colors.black,
                child: Consumer<NotesProviderModel>(
                  builder: (context, myModel, child) {
                    // myModel.updateRemainingTime();
                    return FutureBuilder(
                        future: _getNotesFromDb,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Notes>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [],
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              child: Text("Some error happened"),
                            );
                          } else {
                            if (snapshot.data != null) {
                              List<Notes> notes = snapshot.data ?? null;
                              myModel.setNotesFromDb(notes);
                              myModel.updatePlayPause(true);
                              return Consumer<NotesProviderModel>(
                                  builder: (context, myModel, child) {
                                _controller.addListener(() {
                                  myModel.updatePosition(
                                      _controller.value.position.inSeconds);
                                });
                                return Stack(
                                  children: [
                                    Center(
                                      child: _controller.value.initialized
                                          ? AspectRatio(
                                              aspectRatio:
                                                  _controller.value.aspectRatio,
                                              child: Stack(children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                VideoPlayer(_controller),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    child:
                                                        VideoProgressIndicator(
                                                            _controller,
                                                            allowScrubbing:
                                                                true),
                                                    margin: EdgeInsets.only(
                                                        bottom: 15,
                                                        left: 20,
                                                        right: 20),
                                                  ),
                                                )
                                              ]))
                                          : Container(),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 30, top: 20),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //show note
                                        Column(
                                          children: [
                                            Consumer<NotesProviderModel>(
                                              builder:
                                                  (context, myModel, child) {
                                                if (myModel.showWidget) {
                                                  pauseVideo(myModel);

                                                  // showBottomModal(
                                                  //   context,
                                                  //   ShowNoteModal(
                                                  //       widget.topic,
                                                  //       myModel
                                                  //           .getNote()
                                                  //           .notes,
                                                  //           (noteCallback) {
                                                  //         playVideo(
                                                  //             myModel);
                                                  //         return 0;
                                                  //       }),
                                                  // );
                                                  return Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      child: RaisedButton(
                                                        color: Colors.blue,
                                                        onPressed: () => {
                                                          // pauseVideo(myModel),
                                                          showBottomModal(
                                                            context,
                                                            ShowNoteModal(
                                                                widget.topic,
                                                                myModel
                                                                    .getNote()
                                                                    .notes,
                                                                (noteCallback) {
                                                              playVideo(
                                                                  myModel);
                                                              return 0;
                                                            }),
                                                          )
                                                        },
                                                        child:
                                                            Text("View Note"),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  //   playPauseVideo();
                                                  return Container();
                                                }
                                              },
                                            ),
                                            SizedBox(height: 50),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child:
                                                          FloatingActionButton(
                                                        onPressed: () {
                                                          playPauseVideo(
                                                              myModel);
                                                        },
                                                        child: Icon(
                                                          myModel.isPlay
                                                              ? Icons.pause
                                                              : Icons.play_arrow,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      child: RaisedButton(
                                                        color: Colors.amber,
                                                        onPressed: () => {
                                                          pauseVideo(myModel),
                                                          showBottomModal(
                                                            context,
                                                            NoteInputModal(
                                                                _controller
                                                                    .value
                                                                    .position
                                                                    .inSeconds,
                                                                widget.index,
                                                                (noteCallback) {
                                                              if (noteCallback ==
                                                                  1) {
                                                                myModel
                                                                    .refreshDb();
                                                              }
                                                              playVideo(
                                                                  myModel);
                                                              return 0;
                                                            }),
                                                          )
                                                        },
                                                        child: Text("Add Note"),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                            } else {
                              return Container();
                            }
                          }
                        });
                  },
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void videoListener() {
    print("Duration " + _controller.value.position.inSeconds.toString());
    if (_controller.value.position == _controller.value.duration) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizLayout()),
      );
    }
    // for (int i = 0; i < notesPosition.length; i++) {
    //   if (videoPosition == notesPosition[i].notePosition) {
    //     setState(() {
    //       showNotes = true;
    //       noteToShow = notesPosition[i].notes;
    //     });
    //   }
    // }
  }

  static showBottomModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: child);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
    );
  }

  pauseVideo(NotesProviderModel myModel) {
    if (_controller.value.isPlaying) {
      _controller.pause();
      myModel.updatePlayPause(false);
    }
  }

  playVideo(NotesProviderModel myModel) {
    myModel.updateShowWidget(false);
    myModel.updatePlayPause(true);
    _controller.play();
  }

  void playPauseVideo(NotesProviderModel myModel) {
    if (_controller.value.isPlaying) {
      _controller.pause();
      myModel.updatePlayPause(false);
    } else {
      _controller.play();
      myModel.updatePlayPause(true);
    }
  }

  Future<List<Notes>> getNotesPosition() async {
    var notesPosition = await DBProvider.db.getAllNotes();
    return notesPosition;
  }
}
