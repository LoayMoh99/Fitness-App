import 'package:fitness_app/screens/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const pageDecoration = const PageDecoration(
    pageColor: Color(0xFF192A56),
    bodyTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 36,
    ),
  );

  ///these are the 3 pages details
  var pages = [
    PageViewModel(
      title: "Wanna Be Fit??",
      body: 'Yesss',
      image: Center(child: Image.asset("assets/5.png", height: 175.0)),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: "You CAN be what you Imagined!",
      body: 'How then?!!',
      image: Center(child: Image.asset("assets/4.png", height: 175.0)),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: "➡️ Let's Start ",
      body: '..',
      image: Center(child: Image.asset("assets/6.png", height: 175.0)),
      decoration: pageDecoration,
    ),
  ];
  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      //introduction screen plugin..
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          navigate();
        },
        onSkip: () {
          navigate();
        },
        showSkipButton: true,
        skip: const Icon(
          Icons.skip_next,
          color: Colors.white,
          size: 30,
        ),
        next: const Icon(
          Icons.arrow_right,
          color: Colors.white,
          size: 40,
        ),
        done: const Text(
          "Done",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.deepOrange,
          color: Colors.white60,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
