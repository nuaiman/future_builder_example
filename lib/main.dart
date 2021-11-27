import 'package:flutter/material.dart';
import 'package:future_builder_example/screens/home_screen.dart';
import 'package:future_builder_example/screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  getVisitFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool didVisit = preferences.getBool('didVisit') ?? false;
    return didVisit;
  }

  setVisitFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('didVisit', true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getVisitFlag(),
        builder: (ctx, snapShot) {
          setVisitFlag();

          if (snapShot.data == true) {
            return const HomeScreen();
          }
          return const IntroScreen();
        },
      ),
    );
  }
}
