import 'package:ayiolo_safari_advisor/screens/save_spotted_animal.dart';
import 'package:ayiolo_safari_advisor/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;

class SaveMySpot extends StatefulWidget {
  const SaveMySpot({
    super.key,
  });

  @override
  SaveMySpotState createState() => SaveMySpotState();
}

class SaveMySpotState extends State<SaveMySpot> {
  File? selectedImage;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
    _initializeLocationService();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _initializeLocationService() async {
    await _locationService.initializeLocationService();
  }

  void _pickImageFromCamera() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      final locationData = await _getLocation();

      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (returnedImage == null) {
        print('No image selected');
        return;
      }

      setState(() {
        selectedImage = File(returnedImage.path);
      });

      print('Image selected: ${selectedImage?.path}');
      print(
          'Location at the time of capture - Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SaveSpottedAnimal(
            selectedImage: selectedImage,
            locationData: locationData,
          ),
        ),
      );
    } else {
      _showPermissionDeniedDialog();
      print('Camera permission denied');
    }
  }

  Future<location.LocationData> _getLocation() async {
    // Retrieve the current location
    final location.LocationData currentLocation =
        await _locationService.getCurrentLocation();
    return currentLocation;
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content:
              const Text('To take photos, please grant camera permission.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save My Spot'),
        centerTitle: true,
      ),
      body: Stack(children: [
        Column(
          children: [
            const SizedBox(height: 70.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _pickImageFromCamera();
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
            ),
          ],
        ),
      ]),
    );
  }
}
