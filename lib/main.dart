
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() => runApp(Messi());
class Messi extends StatefulWidget {
  @override
  _MessiState createState() => _MessiState();
}

class _MessiState extends State<Messi> {
  Map images;
  List imgList;
  Future getImage() async {
    http.Response response = await http.get("https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true");
    images = json.decode(response.body);
    setState(() {
     imgList = images['hits']; 
    });
  }
  @override
  initState() {
    super.initState();
    getImage();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(  
        appBar: AppBar(  
          title: Text("Messiy"),
          centerTitle: true,
        ),
        body: ListView.builder(  
          itemCount: imgList != null ? imgList.length: 0,
          itemBuilder: (context, i) {
            return Card(
              child: Column(
                children: <Widget>[
                  Padding(              
                    padding: const EdgeInsets.all(12.0),
                    child:Image.network("${imgList[i]['largeImageURL']}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(imgList[i]['userImageURL']),
                          radius: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${imgList[i]['tags']}"),
                        ),
                        IconButton(icon: Icon(Icons.thumb_up, color: Colors.green,),)
                        IconButton(icon: Icon(Icons.thumb_down, color: Colors.green,),)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}