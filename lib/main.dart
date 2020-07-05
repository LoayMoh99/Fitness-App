import 'package:fitness_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      theme: ThemeData(
        primaryColorDark: Color(0xFF192A56),
        primaryColor: Colors.blue[800],
        accentColor: Colors.blueAccent
      ),
    );
  }
}
