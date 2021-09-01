import 'dart:io';

import 'package:firebase_ml_vision_raw_bytes/firebase_ml_vision_raw_bytes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocrapp/MainScreenForm.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "";
  String lineResult = '';
  List lineResultList = [];
  File image;
  Future<File> imageFile;
  ImagePicker imagePicker;

  pickImageFromGallery() async {
    XFile pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    image = File(pickedFile.path);

    setState(() {
      image;

      //do image labelling- extract text from image
      performImageLabelling();
    });
  }

  captureImageWithCamera() async {
    XFile pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    image = File(pickedFile.path);

    setState(() {
      image;

      //do image labelling- extract text from image
      performImageLabelling();
    });
  }

  performImageLabelling() async {
    final FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(image);

    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

    // final TextRecognizer recognizer =
    //     FirebaseVision.instance.cloudTextRecognizer();

    VisionText visionText = await recognizer.processImage(firebaseVisionImage);

    result = '';

    setState(() {
      for (TextBlock block in visionText.blocks) {
        final String txt = block.text;
        result += block.text;
        for (TextLine line in block.lines) {
          lineResult += line.text + "\n";
          lineResultList.add(line.text);
          //   // for (TextElement element in line.elements) {
          //   //   // result += element.text + " ";
          //   // }
        }

        result += "\n\n";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 20.0), color: Colors.blue),
        child: Column(
          children: [
            SizedBox(
              width: 100,
            ),
            Container(
              height: 280,
              width: 350,
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.only(left: 10, bottom: 1, right: 10),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(5),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            print("elevated button pressed");

                            pickImageFromGallery();
                          },
                          label: Text('pick from gallery'),
                          icon: Icon(Icons.camera),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              primary: Colors.purple,
                              textStyle: TextStyle(
                                fontSize: 15,
                              ),
                              minimumSize: Size(20, 40)),
                        )),
                    Container(
                        margin: const EdgeInsets.all(2),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            print("elevated button pressed (picture)");
                            captureImageWithCamera();
                          },
                          label: Text('Take a picture'),
                          icon: Icon(Icons.camera_rear),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              primary: Colors.purple,
                              textStyle: TextStyle(
                                fontSize: 15,
                              ),
                              minimumSize: Size(10, 40)),
                        )),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: image != null
                      ? Image.file(
                          image,
                          width: 140,
                          height: 192,
                          fit: BoxFit.fill,
                        )
                      : Text("No picture chosen")),
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(2),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print("confrim button pressed");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreenForm(
                                      lineResultList: lineResultList,
                                    )));
                      },
                      label: Text('Confirm'),
                      icon: Icon(Icons.arrow_forward_rounded),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          primary: Colors.purple,
                          textStyle: TextStyle(
                            fontSize: 15,
                          ),
                          minimumSize: Size(10, 40)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
