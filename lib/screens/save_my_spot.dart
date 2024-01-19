import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class SaveMySpot extends StatefulWidget {
  const SaveMySpot({
    Key? key,
  }) : super(key: key);

  @override
  _SaveMySpotState createState() => _SaveMySpotState();
}

class _SaveMySpotState extends State<SaveMySpot> {
  String? _imagePath;

  Future<void> _takePhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save My Spot')),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: _imagePath == null
                ? Center(child: Text('No image selected'))
                : Image.file(File(_imagePath!)),
          ),
          ElevatedButton.icon(
            onPressed: _takePhoto,
            icon: Icon(Icons.camera),
            label: Text('Take Photo'),
          ),
        ],
      ),
    );
  }
}
