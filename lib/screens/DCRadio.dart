

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';



class DCRadio extends StatefulWidget {
  @override
  _DCRadioState createState() => _DCRadioState();
}

class _DCRadioState extends State<DCRadio> {
 final _volumeSubject = BehaviorSubject.seeded(1.0);
  final _speedSubject = BehaviorSubject.seeded(1.0);
  AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setUrl(
        "https://listen.radioking.com/radio/287098/stream/333175");
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
         appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.blue.shade900),
        elevation: 15.0,
        title: Column(children: <Widget>[
         Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 2)),
                      Image(
                          image: AssetImage("assets/domcitylogo2.jpg"),
                          width: 50,
                          height: 50),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 80),
                        child: new Text(
                          'Dominion City',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        child: new Text(
                          '...raising leaders that transforms society',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
        actions: <Widget>[],
        backgroundColor: Colors.white,
         ),
        body: Container(
         decoration: BoxDecoration(
              color: Colors.blue.shade900,
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade900, Colors.blue.shade300],
              ),
            ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Online Radio Station', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'OpenSans'),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('(Live Sessions, Previous Messages and Announcements)', style: TextStyle(color: Colors.white),),
                  ],
                ),
                SizedBox(height: 150),
                StreamBuilder<FullAudioPlaybackState>(
                  stream: _player.fullPlaybackStateStream,
                  builder: (context, snapshot) {
                    final fullState = snapshot.data;
                    final state = fullState?.state;
                    final buffering = fullState?.buffering;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state == AudioPlaybackState.connecting ||
                            buffering == true)
                          Container(
                            margin: EdgeInsets.all(8.0),
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(backgroundColor: Colors.white,),
                          )
                        else if (state == AudioPlaybackState.playing)
                        GestureDetector(
                          onTap: (){_player.pause();},
                          child: Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("assets/pause.png"),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                               boxShadow: [
                                 BoxShadow(blurRadius: 20.0, color: Colors.black)
                               ]
                               // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                              ),

                            ),
                        )

                        else
                         GestureDetector(
                          onTap: (){_player.play();},
                          child: Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("assets/play.png"),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                               boxShadow: [
                                 BoxShadow(blurRadius: 20.0, color: Colors.black)
                               ]
                               // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                              ),

                            ),
                        ),

                        SizedBox(width:20),
                        GestureDetector(
                           onTap: state == AudioPlaybackState.stopped ||
                                  state == AudioPlaybackState.none
                              ? null
                              : _player.stop,
                          child: Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("assets/stop.png"),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                               boxShadow: [
                                 BoxShadow(blurRadius: 20.0, color: Colors.black)
                               ]
                               // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid)
                              ),

                            ),
                        )
                        // IconButton(
                        //   icon: Icon(Icons.stop),
                        //   iconSize: 64.0,
                        //   onPressed: state == AudioPlaybackState.stopped ||
                        //           state == AudioPlaybackState.none
                        //       ? null
                        //       : _player.stop,
                        // ),
                      ],
                    );
                  },
                ),

                SizedBox(height:40),
                Text("Track position", style: TextStyle(color: Colors.white),),
                StreamBuilder<Duration>(
                  stream: _player.durationStream,
                  builder: (context, snapshot) {
                    final duration = snapshot.data ?? Duration.zero;
                    return StreamBuilder<Duration>(
                      stream: _player.getPositionStream(),
                      builder: (context, snapshot) {
                        var position = snapshot.data ?? Duration.zero;
                        if (position > duration) {
                          position = duration;
                        }
                        return SeekBar(
                          duration: duration,
                          position: position,
                          onChangeEnd: (newPosition) {
                            _player.seek(newPosition);
                          },
                        );
                      },
                    );
                  },
                ),
                Text("Volume",style: TextStyle(color:Colors.white,),),
                StreamBuilder<double>(
                  stream: _volumeSubject.stream,
                  builder: (context, snapshot) => Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    divisions: 20,
                    min: 0.0,
                    max: 2.0,
                    value: snapshot.data ?? 1.0,
                    onChanged: (value) {
                      _volumeSubject.add(value);
                      _player.setVolume(value);
                    },
                  ),
                ),
                Text("Speed",style: TextStyle(color:Colors.white,),),
                StreamBuilder<double>(
                  stream: _speedSubject.stream,
                  builder: (context, snapshot) => Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: snapshot.data ?? 1.0,
                    onChanged: (value) {
                      _speedSubject.add(value);
                      _player.setSpeed(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
    
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.white,
      inactiveColor: Colors.white,
      min: 0.0,
      max: widget.duration.inMilliseconds.toDouble(),
      value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
      onChanged: (value) {
        setState(() {
          _dragValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged(Duration(milliseconds: value.round()));
        }
      },
      onChangeEnd: (value) {
        _dragValue = null;
        if (widget.onChangeEnd != null) {
          widget.onChangeEnd(Duration(milliseconds: value.round()));
        }
      },
    )
    ;
  }
}