import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/utils/excersise_hub.dart';
import 'package:flutter/material.dart';

class ExersiseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;

  ExersiseScreen({@required this.exercises, @required this.seconds});
  @override
  _ExersiseScreenState createState() => _ExersiseScreenState();
}

class _ExersiseScreenState extends State<ExersiseScreen> {
  bool _isChecked =
      false; //helps to detect if the specific time is done or not yet..
  int _elapsedSeconds = 0;

  Timer timer;
  AudioCache audioCache = AudioCache();

  void playAudio() {
    audioCache.play('cheering1.mp3');
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              child: CachedNetworkImage(
                imageUrl: widget.exercises.gif,
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
          SafeArea(
            child: (!_isChecked)
                ? Container(
                    padding: const EdgeInsets.only(top: 25),
                    alignment: Alignment.topCenter,
                    child: Text(
                      '$_elapsedSeconds / ${widget.seconds} sec',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.pink,
                        child: Text(
                          'Done!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ),
          SafeArea(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
