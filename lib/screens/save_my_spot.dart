import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SaveMySpot extends StatefulWidget {
  const SaveMySpot({super.key});

  @override
  State<SaveMySpot> createState() => _SaveMySpotState();
}

class _SaveMySpotState extends State<SaveMySpot> {
  XFile? _imageFile;

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('Share what you saw to help Save animals!'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Hero(
              tag: 'save_my_spot',
              child: Container(
                height: 400,
                width: 400,
                decoration: _imageFile != null
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(_imageFile!.path)),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ayiolo_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 60.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.camera);
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 212, 208, 208),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Center(
                  child: Text('Take Photo',
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 212, 208, 208),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Center(
                  child: Text('Get from Gallery',
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
