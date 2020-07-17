import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/detail_screen.dart';
import 'package:fitness_app/utils/excersise_hub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiURL =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  //detect if there is network or no..
  bool noNetwork = false;
  Future<ExcersiseHub> _getExcersises() async {
    var response;
    try {
      response = await http.get(apiURL);
    } catch (e) {
      return null;
    }
    var bodyResponse = response.body;
    var decodedJson = jsonDecode(bodyResponse);
    return ExcersiseHub.fromJson(decodedJson);
  }

  Widget listExercises(ExcersiseHub excersiseHub) {
    return ListView(
      children: excersiseHub.exercises.map((e) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DetailScreen(
                  exercises: e,
                );
              }),
            );
          },
          child: Hero(
            tag: e.id,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: e.thumbnail,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image(
                        image: AssetImage('assets/placeholder.jpg'),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Color(0xFF000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      child: Text(
                        e.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Fitness App'),
        ),
      ),
      body: FutureBuilder<ExcersiseHub>(
        future: _getExcersises(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.error == true || snapshot.data == null) {
            //if no internet or there is an error..
            return Center(
              child: Text(
                'Error\nNo Internet!',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done)
              return Material(
                child: listExercises(snapshot.data),
              );
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return Center(
                child: Text(
                  'Unexpected!',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _getExcersises();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
