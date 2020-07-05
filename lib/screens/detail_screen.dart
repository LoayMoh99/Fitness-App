import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/exersise_screen.dart';
import 'package:fitness_app/utils/excersise_hub.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailScreen extends StatefulWidget {
  final Exercises exercises;

  DetailScreen({@required this.exercises});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int seconds = 30;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Hero(
        tag: widget.exercises.id,
        child: Stack(
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                imageUrl: widget.exercises.thumbnail,
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF000000),
                    Color(0x00000000),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Center(
              child: InkWell(
                splashColor: Colors.black54,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ExersiseScreen(
                        exercises: widget.exercises,
                        seconds: seconds,
                      );
                    }),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent[400],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Start Excersise',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 3,
                child: SleekCircularSlider(
                  min: 10,
                  max: 60,
                  initialValue: 30,
                  onChange: (value) {
                    seconds = value.toInt();
                  },
                  innerWidget: (value) {
                    // use your custom widget inside the slider (gets a slider value from the callback)
                    return Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${value.toInt()} sec',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
