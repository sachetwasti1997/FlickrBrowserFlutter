import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'src/ImageModel.dart';
import 'src/ImageList.dart';

class MyApp extends StatefulWidget{

  String tags;

  MyApp(this.tags);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState(tags);
  }

}

class MyAppState extends State<MyApp>{

  String tags;

  MyAppState(this.tags);

  var items;
  int counter = -1;
  List<ImageModel> images = new List();
  bool isLoading = true;

  void fetchJson() async{

    print("fetchJson called");
    final response = await get("https://api.flickr.com/services/feeds/photos_public.gne?tags=${this.tags}&format=json&nojsoncallback=1");
    final jsonData = jsonDecode(response.body);
    items = jsonData['items'];
    print(items);
  }


  void makeObject(){
    counter++;
    var image = ImageModel(items[counter]);
    setState(() {
      isLoading = false;
      images.add(image);
    });
  }

  @override
  void initState() {
    fetchJson();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home:Scaffold(

          appBar: AppBar(
            title: Text("FlickrImages"),
          ),

          body: Center(
            child: isLoading ? CircularProgressIndicator():
            ImageList(images),
          ),

          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: makeObject
          ),

        ),
    );

  }

}