import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/utils/excersise_hub.dart';
import 'package:flutter/material.dart';

class ExersiseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;

  const ExersiseScreen({@required this.exercises, @required this.seconds});
  @override
  _ExersiseScreenState createState() => _ExersiseScreenState();
}

class _ExersiseScreenState extends State<ExersiseScreen> {
  bool _isChecked = false;
  int _elapsedSeconds = 0;

  Timer timer;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  void playAudio() {
    audioCache.play('cheering1.mp3');
  }

  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (t.tick == widget.seconds) {
          timer.cancel();
          setState(() {
            _isChecked = true;
          });
          playAudio();
        } else {
          setState(() {
            _elapsedSeconds = t.tick;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            child: CachedNetworkImage(
              imageUrl: widget.exercises.gif,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              placeholder: (context, url) => Image(
                image: AssetImage('assets/placeholder.jpg'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        (_isChecked)
            ? SafeArea(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '$_elapsedSeconds / ${widget.seconds} sec',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              )
            : Container(),
        SafeArea(
          child: Container(
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }
}
