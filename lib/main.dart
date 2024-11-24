import 'package:flutter/material.dart';
import 'package:untitled/JourneyMap.dart';
import 'package:untitled/LoginPage.dart';
import 'package:untitled/MainScreen.dart';
import 'package:untitled/NewJournal.dart';
import 'package:untitled/ViewJournal.dart';
import 'package:untitled/journal_entry.dart';

void main() {
  runApp(const TravelJournal());
}

class TravelJournal extends StatelessWidget {
  const TravelJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel Journal',
      home: const LoginPage(),
      routes: {
        '/MainScreen': (context) => const MainScreen(),
        '/NewJournal': (context) => NewJournal(),
        // '/ViewJournal': (context) => ViewJournal(
<<<<<<< HEAD
        '/ViewJournal': (context) => const ViewJournal(),
        '/JourneyMap':(context) => const JourneyMap(),
    },    );
=======
        '/ViewJournal': (context) => ViewJournal(),
        '/JourneyMap': (context) => JourneyMap(),
      },
    );
>>>>>>> 21cd1606a18a3e4f96463b8ec73c2c180d46c8d2
  }
}
