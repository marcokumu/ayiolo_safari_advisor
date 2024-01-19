import 'package:ayiolo_safari_advisor/services/location_service.dart';
import 'package:ayiolo_safari_advisor/widgets/animal_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveSpottedAnimal extends StatefulWidget {
  const SaveSpottedAnimal({super.key});

  @override
  State<SaveSpottedAnimal> createState() => _SaveSpottedAnimalState();
}

String spottedAnimal = 'Aardvark';

class _SaveSpottedAnimalState extends State<SaveSpottedAnimal> {
  LatLng? _currentLocation;

  final LocationService _locationController = LocationService();
  late StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _locationSubscription = _locationController.getLocationUpdates(
      (double latitude, double longitude) {
        setState(() {
          _currentLocation = LatLng(latitude, longitude);
        });
      },
    );
  }

  void _saveDataToFirestore(String userId) async {
    if (spottedAnimal.isNotEmpty && _currentLocation != null) {
      String dateSpotted = DateFormat('MMMM dd, yyyy').format(DateTime.now());

      // Create a Firestore document reference with userId
      DocumentReference userReference =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference saveSpotCollection =
          userReference.collection('save_my_spot');

      // Check if the user document exists, create it if not
      if (!(await userReference.get()).exists) {
        await userReference.set({
          // Add any additional user-specific data here
        });
      }

      // Save data to Firestore in the 'save_my_spot' subcollection
      DocumentReference documentReference = await saveSpotCollection.add({
        'spottedAnimal': spottedAnimal,
        'dateSpotted': dateSpotted,
        'locationSpotted': {
          'latitude': _currentLocation!.latitude,
          'longitude': _currentLocation!.longitude,
        },
      });

      // Optionally, you can print the document ID or a success message
      print(
          'Data saved to Firestore with document ID: ${documentReference.id}');
    } else {
      // Print a message if data is null
      print('Data is null or incomplete. Not saving to Firestore.');
    }
  }

  void saveData() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';
    print('userId: $userId');
    _saveDataToFirestore(userId);
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
              ),
              child: AnimalList(onAnimalSelected: (String animal) {
                setState(() {
                  if (spottedAnimal == animal) {
                    spottedAnimal = '';
                  } else {
                    spottedAnimal = animal;
                  }
                });
              }),
            ),
          ),
          const SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Great you\'ve spotted:   '),
              Text(
                spottedAnimal,
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 60.0),
          Text(
              'Spotted on: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}'),
          const SizedBox(height: 60.0),
          Text(
            _currentLocation != null
                ? 'Current Location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}'
                : 'Loading...',
          ),
          Container(
            height: 70,
            width: 100,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 212, 208, 208),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Center(
              child: InkWell(
                  onTap: () {
                    saveData();
                  },
                  child: Text('Save',
                      style: Theme.of(context).textTheme.labelLarge)),
            ),
          ),
        ],
      ),
    );
  }
}
