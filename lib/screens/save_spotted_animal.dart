import 'package:ayiolo_safari_advisor/screens/ayiolo.dart';
import 'package:ayiolo_safari_advisor/widgets/animal_list.dart';
import 'package:ayiolo_safari_advisor/widgets/pill_choice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:location/location.dart' as location;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SaveSpottedAnimal extends StatefulWidget {
  final File? selectedImage;
  final location.LocationData? locationData;

  const SaveSpottedAnimal(
      {super.key, this.selectedImage, required this.locationData});

  @override
  State<SaveSpottedAnimal> createState() => _SaveSpottedAnimalState();
}

String spottedAnimal = '';
String selectedPill = '';
Mode currentMode = Mode.Animal;

class _SaveSpottedAnimalState extends State<SaveSpottedAnimal> {
  bool isSaving = false;

  Future<DocumentReference> _saveDataToFirestore(String userId) async {
    if (widget.locationData != null && widget.selectedImage != null) {
      String dateSpotted = DateFormat('MMMM dd, yyyy').format(DateTime.now());

      // Create a Firestore document reference with userId
      DocumentReference userReference =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference saveSpotCollection =
          userReference.collection('save_my_spot');

      // Upload the image to Firebase Storage
      String imagePath =
          'images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);

      await storageReference.putFile(widget.selectedImage!);

      // Get the download URL for the image
      String imageURL = await storageReference.getDownloadURL();

      // Prepare data to save
      Map<String, dynamic> dataToSave = {
        'userId': userId,
        'spottedAnimal': spottedAnimal,
        'dateSpotted': dateSpotted,
        'imageURL': imageURL,
        'locationSpotted': {
          'latitude': widget.locationData!.latitude,
          'longitude': widget.locationData!.longitude,
        },
        'spotName': selectedPill,
        'createdAt': FieldValue.serverTimestamp(),
      };
      print('Data to save: $dataToSave');

      // Save data to Firestore in the 'save_my_spot' subcollection
      DocumentReference documentReference =
          await saveSpotCollection.add(dataToSave);

      
      print('Data saved to Firestore! Document ID: ${documentReference.id}');

      return documentReference;
    } else {
      // Print a message if data is null
      print('Data is null or incomplete. Not saving to Firestore.');
      return FirebaseFirestore.instance
          .doc('dummy');
    }
  }

  void saveData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';
    print('userId: $userId');

    setState(() {
      isSaving = true;
    });

    // Save data and get the document reference
    DocumentReference documentReference = await _saveDataToFirestore(userId);

    setState(() {
      isSaving = false;
    });

    // Check if the document was successfully added
    if (documentReference.id.isNotEmpty) {
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text('Spot saved successfully!'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Ayiolo()),
      );
    } else {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving spot. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Reset both modes
  void resetBothModes() {
    setState(() {
      selectedPill = '';
      spottedAnimal = '';
      currentMode = Mode.Animal;
    });
  }

  void showImagePreviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(widget.selectedImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          const Text(
            'What did you spot?',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PillChoice(
                label: 'A Gate',
                isSelected: selectedPill == 'Gate',
                onTap: () {
                  setState(() {
                    selectedPill = 'Gate';
                    currentMode = Mode.Pill;
                  });
                },
              ),
              const SizedBox(width: 10),
              PillChoice(
                label: 'A Picnic site',
                isSelected: selectedPill == 'Picnic site',
                onTap: () {
                  setState(() {
                    selectedPill = 'Picnic site';
                    currentMode = Mode.Pill;
                  });
                },
              ),
              const SizedBox(width: 10),
              PillChoice(
                label: 'A Viewpoint',
                isSelected: selectedPill == 'Viewpoint',
                onTap: () {
                  setState(() {
                    selectedPill = 'Viewpoint';
                    currentMode = Mode.Pill;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Center(
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: AnimalList(
                onAnimalSelected: (String animal) {
                  if (currentMode == Mode.Animal) {
                    setState(() {
                      if (spottedAnimal == animal) {
                        spottedAnimal = '';
                      } else {
                        spottedAnimal = animal;
                      }
                    });
                  }
                },
                isEnabled: currentMode == Mode.Animal,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: resetBothModes,
                child: Container(
                  height: 40,
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: const Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showImagePreviewDialog();
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                  child: const Center(child: Text("Image Preview")),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Great you\'ve spotted:   '),
              Text(
                currentMode == Mode.Pill
                    ? selectedPill
                    : (spottedAnimal.isNotEmpty ? spottedAnimal : ''),
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
              'Spotted on: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}'),
          const SizedBox(height: 30.0),
          GestureDetector(
            onTap: () {
              saveData();
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 212, 208, 208),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                  child: isSaving
                      ? const CircularProgressIndicator()
                      : Text('Save',
                          style: Theme.of(context).textTheme.labelLarge)),
            ),
          ),
        ],
      ),
    );
  }
}

enum Mode {
  Animal,
  Pill,
}
