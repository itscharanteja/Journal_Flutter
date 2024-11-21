import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:untitled/ViewJournal.dart';

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/journal_entry.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';



class NewJournal extends StatefulWidget {
  @override
  State<NewJournal> createState() => _NewJournal();
}

class _NewJournal extends State<NewJournal> {

  List<File> _images =[];
  String? _selectedLocation;

  final _titleController=TextEditingController();
  final _contentController=TextEditingController();
  final  _locationController= TextEditingController();

  Timer? _debounce;

  Future<void> _getImage(ImageSource source) async{


    try{
      final imagePicker = ImagePicker();
      final pickedImage=await imagePicker.pickImage(source:source);
      if (pickedImage!=null){
        setState(() {
          _images.add(File(pickedImage.path));
        });
      }
      else{
        print("NO image selected");
      }
    }
    catch(e){
      print("Error selecting the image.");
    }




  }


  Future<void> _saveJournal() async{

    String title= _titleController.text;
    String content=_contentController.text;

    if(title.isEmpty || content.isEmpty||_images.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    await _saveJournalEntry(title,content,_images);


    // Navigator.pop(context);
    Navigator.pushNamed(context, '/MainScreen');

  }

  Future<List<JournalEntry>> _loadJournalEntries() async{
    final directory= await getApplicationDocumentsDirectory();
    final journalFile = File('${directory.path}/journals.json');
    if (!await journalFile.exists()) return [];

    final String fileContent=await journalFile.readAsString();
    final List<dynamic> data=jsonDecode(fileContent);
    return data.map((entry){
      return JournalEntry(
        title: entry['title'],
        content: entry['content'],
        imagePaths: (jsonDecode(entry['imagePaths']) as List<dynamic>).isNotEmpty
            ? (jsonDecode(entry['imagePaths']) as List<dynamic>).first
            : '',
      );
    }).toList();

  }

  Future<void> _saveJournalEntry(String title,String content,List<File> images) async
  {
    try {
      List<String> imagePaths=[];

      final directory = await getApplicationDocumentsDirectory();
      for (var image in images){
        final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
        await image.copy(imagePath);
        imagePaths.add(imagePath);

      }


      Map<String, String> journalData = {
        'title': title,
        'content': content,
        'imagePaths': jsonEncode(imagePaths),
        'location':_selectedLocation??'',
      };

      final journalFile = File('${directory.path}/journals.json');
      List<dynamic> existingData = [];

      if (await journalFile.exists()) {
        final String fileContent = await journalFile.readAsString();
        existingData = jsonDecode(fileContent);
      }
      existingData.add(journalData);

      await journalFile.writeAsString(jsonEncode(existingData));
      print("Jounral Data saved at ${journalFile.path}");
    }
    catch (e) {
      print("error saving journal: $e");
    }
  }

  Future<void> _getCurrentLocation() async{

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location Service is disabled")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permiission denied.')),);
          return;
        }
        // AndroidSettings androidSettings =AndroidSettings(
        //   accuracy: LocationAccuracy.high,
        //   distanceFilter: 10,
        //   forceLocationManager: false,
        //   intervalDuration: Duration(seconds: 10),
        // );
        //
        // final locationSettings = LocationSettings(
        //   accuracy: LocationAccuracy.high,
        //   distanceFilter: 10,
        // );

        Position position =await Geolocator.getCurrentPosition(
          desiredAccuracy:LocationAccuracy.high,
        );

        if (permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Rejected Location permission completely")));
          return;
        }

        List<Placemark> placemarks= await placemarkFromCoordinates(position.latitude, position.longitude);

        if(placemarks.isNotEmpty){
          Placemark place=placemarks[0];
          String locationName="${place.locality}, ${place.administrativeArea},${place.country}";

          setState(() {
            _selectedLocation = "${position.latitude},${position.longitude}";

            _locationController.text=locationName;
          });
        }
        else{
          setState(() {
            _selectedLocation="${position.latitude},${position.longitude}";
            _locationController.text="My location";
          });
        }




        // setState(() {
        //   _selectedLocation = "${position.latitude},${position.longitude}";
        //   _locationController.text="My Location";
        // });


        // Position position =await Geolocator.getCurrentPosition();
        // setState(() {
        //   _selectedLocation="${position.latitude}, ${position.longitude}";
        // });
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error in accessing the location!")),
      );
    }





  }

  @override
  void dispose(){
    _titleController.dispose();
    _contentController.dispose();
    _locationController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "NewJournal",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              TextField(

                style: TextStyle(fontSize: 20),
                controller:_titleController ,
              decoration: InputDecoration(hintText: "Journal Title"),),
              SizedBox(height: 20,),
              TextField(
                maxLines: 6,
                controller: _contentController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(hintText: "Description"),
              ),
              SizedBox(height: 20,),

              TextField(controller: _locationController,onChanged: (value) {
                if(_debounce?.isActive??false)
                  _debounce!.cancel();
                _debounce=Timer(const Duration(milliseconds: 500),()async{
                try {
                  List<Location> locations = await locationFromAddress(value);
                  if (locations.isNotEmpty) {
                    Location location = locations.first;
                    setState(() {
                      _selectedLocation = "${location.latitude},${location
                          .longitude}";
                    });
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No location found \"$value\"")),

                    );
                  }
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error finding location: $e ")),
                  );
                }
              }


                );
              },
              decoration:InputDecoration(hintText: "Enter location:(eg: New York)"),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: _getCurrentLocation, child:Text("Use GPS location")),

              _selectedLocation !=null? Text("Selected Location: $_selectedLocation") : SizedBox(),


              SizedBox(height: 20,),
              _images.isNotEmpty
                  ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _images.map((image) {

                    return Stack(
                      children: [
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Image.file(image, height: 200, width: 200),),
                        Positioned(
                    right: 0,top: 0
                    ,child: IconButton(icon:Icon(Icons.cancel,color:Colors.red) ,
                    onPressed: (){
                      setState(() {
                        _images.remove(image);
                      });
                        }, )
                        ),],

                    );
                  }).toList(),
                ),
              )
                  : Text("No images selected."),

              // _image!=null? Image.file(_image!,height: 200,width: 200,) :
              // Text("No image selected."),


              SizedBox(height: 20,),

              ElevatedButton(onPressed: () => _getImage(ImageSource.gallery),
                  child: Text("Select image"),),

              SizedBox(height: 20,),

              ElevatedButton(onPressed:() => _getImage(ImageSource.camera),
                  child: Text("Click a photo"), ),

              SizedBox(height: 20,),

              ElevatedButton(onPressed:_saveJournal
                  , child:Text("Save journal")),





            ],
          ),
        ),
      ),
    );
  }
}
