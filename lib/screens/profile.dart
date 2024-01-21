import 'package:ayiolo_safari_advisor/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Map<String, dynamic>> _savedSpots;
  late int total;
  bool isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _savedSpots = [];
    total = 0;
    _fetchSavedSpots();
  }

  Future<void> _fetchSavedSpots() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';

    // Fetch saved spots from Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('save_my_spot')
        .get();

    // Update the _savedSpots list with fetched data
    setState(() {
      _savedSpots = querySnapshot.docs
          .map((doc) => {
                'location': LatLng(
                  doc['locationSpotted']['latitude'],
                  doc['locationSpotted']['longitude'],
                ),
                'spottedAnimal': doc['spottedAnimal'],
                'dateSpotted': doc['dateSpotted'],
                'imageURL': doc['imageURL'],
              })
          .toList(); // Explicitly cast to List<Map<String, dynamic>>
      total = _savedSpots.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            const SizedBox(height: 60.0),
            Text('You have $total saved spots!'),
            const SizedBox(height: 60.0),
            Center(
              child: SizedBox(
                height: 400,
                width: 400,
                child: _savedSpots.isEmpty
                    ? Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/save_my_spot');
                          },
                          child: Container(
                            height: 70,
                            width: 300,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 212, 208, 208),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Center(
                              child: Text('Add spots',
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ),
                          ),
                        ),
                      )
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _savedSpots.first['location'],
                          zoom: 13,
                        ),
                        markers: _savedSpots
                            .map(
                              (spot) => Marker(
                                markerId: MarkerId(spot['location'].toString()),
                                position: spot['location'],
                                infoWindow: InfoWindow(
                                  title: spot['spottedAnimal'],
                                  snippet: 'Spotted on: ${spot['dateSpotted']}',
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(spot['spottedAnimal']),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              isLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : Image.network(
                                                      '${spot['imageURL']}',
                                                      height: 400,
                                                      width: 400,
                                                      fit: BoxFit.cover,
                                                    ),
                                              const SizedBox(height: 10),
                                              Text(
                                                  'Date Spotted: ${spot['dateSpotted']}'),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Close'),
                                            ),
                                          ],
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                            .toSet(),
                      ),
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: IconButton(
            onPressed: () {
              _authService.signOut();
              Navigator.pushReplacementNamed(context, '/auth_page');
            },
            icon: const Icon(Icons.output_sharp),
          ),
        )
      ]),
    );
  }
}
