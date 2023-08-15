import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'api.dart';

class ResultPage extends StatefulWidget {
  final File image;

  const ResultPage({Key? key, required this.image}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState(image);
}

class _ResultPageState extends State<ResultPage> {
  String captions = "Refresh once!";
  var data;
  File? image;
  FlutterTts ftts = FlutterTts();

  _ResultPageState(this.image);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFF2193B0),
            Color(0xFF6DD5ED),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              //   padding: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: Colors.white,
              //   ),
                child: Text(
                  "Captions",
                  style: TextStyle(fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: displayImage(image),
              ),
              SizedBox(height: 20),
              Container(
                height: 125,
                width: 350,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                  captions, style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("Refresh"),

                    onPressed: () => getCaption(),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    child: Text("Audio"),
                    onPressed: () => speakCaption(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getCaption() async {
    data = await getData(uploadUrl);

    setState(() {
      captions = data['captions'];
    });
  }

  speakCaption() async {
    await ftts.setLanguage("en-US");
    await ftts.setPitch(1);
    await ftts.speak(captions);
  }

  Widget displayImage(File? image) {
    if (image == null) {
      return Container();
    } else {
      return AspectRatio(
        aspectRatio: 1.0,
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      );
    }
  }

}