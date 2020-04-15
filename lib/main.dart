import 'package:covid_19_tracker/notifiers/HistoryResponseNotifier.dart';
import 'package:covid_19_tracker/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => HistoryResponseNotifier(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Proxima',
        primaryColor: Color(0xFF222B45),
        scaffoldBackgroundColor: Color(0xFFF2F3F6),
      ),
      home: HomeScreen(),
    );
  }
}
