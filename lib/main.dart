import 'package:flutter/material.dart';
import 'package:untitled/JourneyMap.dart';
import 'package:untitled/LoginPage.dart';
import 'package:untitled/MainScreen.dart';
import 'package:untitled/NewJournal.dart';
import 'package:untitled/ViewJournal.dart';
import 'package:untitled/journal_entry.dart';

void main() {
  runApp(TravelJournal());
}

class TravelJournal extends StatelessWidget {
  const TravelJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel Journal',
      home: LoginPage(),
      routes: {
        '/MainScreen': (context) => MainScreen(),
        '/NewJournal': (context) => NewJournal(),
        // '/ViewJournal': (context) => ViewJournal(
        '/ViewJournal': (context) => ViewJournal(),
        '/JourneyMap':(context) => JourneyMap(),
    },    );
  }
}
