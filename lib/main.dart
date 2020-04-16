import 'package:covid_19_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Proxima',
        // primaryColor: Color(0xFF222B45),
        primaryColor: Color(0xFF3F5673),
        // scaffoldBackgroundColor: Color(0xFFF2F3F6),
        scaffoldBackgroundColor: Color(0xFFF5F7FD),
      ),
      home: HomeScreen(),
    );
  }
}
