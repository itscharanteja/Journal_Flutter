import 'package:flutter/material.dart';
import 'package:untitled/JourneyMap.dart';
import 'package:untitled/ViewJournal.dart';
import 'journal_entry.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();


}


class _MainScreenState extends State<MainScreen> {


  List<JournalEntry> journalEntries = [];







  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'HomePage',
          style: TextStyle(
              color: Colors.white70, fontSize: 24, fontWeight: FontWeight.w700),
        ),

        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Text('Hello!',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                // SizedBox(height: 20,),
                Container(

                  height: 150,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      spreadRadius: 10,
                    ),
                  ], color: Colors.white70),
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/NewJournal');
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Create New Journal",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 19),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey[900]),
                  ),

                ),
                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 100,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewJournal()),
                      );
                    },
                    icon: const Icon(
                      Icons.view_module_sharp,
                      color: Colors.amber,
                    ),
                    label: const Text(
                      "View Journal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 19),
                        backgroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),

                SizedBox(height: 20,),
                SizedBox(
                  height: 100,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: (

                    ) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> JourneyMap()),);
                    },
                    icon: const Icon(
                      Icons.map,
                      color: Colors.pink,
                    ),
                    label: const Text(
                      "My Journies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 19),
                        backgroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}