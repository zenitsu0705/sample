import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'result_page.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  File? _image;

  Future<void> getImage(bool isCamera) async {
    try {
      XFile? xFile;
      if (isCamera) {
        xFile = await ImagePicker().pickImage(source: ImageSource.camera);
      } else {
        xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      }

      if (xFile != null) {
        final file = File(xFile.path); // Convert XFile to File
        uploadImage(file, uploadUrl);
        Fluttertoast.showToast(
          msg: "IMAGE UPLOADED !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white12,
          textColor: Colors.black,
          fontSize: 16.0,
        );

        setState(() {
          _image = file;
        });
      }
    } catch (e) {
      print("Failed to pick image: $e");
    }
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Caption AI',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.insert_drive_file),
                color: Colors.white,
                iconSize: 70,
                onPressed: () {
                  getImage(false);
                },
              ),
              SizedBox(height: 70.0),
              IconButton(
                icon: Icon(Icons.camera_alt),
                color: Colors.white,
                iconSize: 70,
                onPressed: () {
                  getImage(true);
                },
              ),
              SizedBox(height: 70.0),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_image != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultPage(image: _image!)),
              );
            } else {
              Fluttertoast.showToast(
                msg: "Please select an image!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white12,
                textColor: Colors.black,
                fontSize: 16.0,
              );
            }
          },
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: 30,
          ),
          label: Text(
            "Next",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
