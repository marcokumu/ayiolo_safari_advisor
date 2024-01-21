import 'package:ayiolo_safari_advisor/services/location_service.dart';
import 'package:ayiolo_safari_advisor/widgets/animal_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class FindAnimals extends StatefulWidget {
  const FindAnimals({super.key});

  @override
  State<FindAnimals> createState() => _FindAnimalsState();
}

String animalToFind = '';

class _FindAnimalsState extends State<FindAnimals> {
  List<Map<String, dynamic>> matchingAnimals = [];
  bool isLoading = false;

  final LocationService _locationService = LocationService();
  LatLng? currentLocation;
  late StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    _initializeLocationService();
  }

  Future<void> _initializeLocationService() async {
    await _locationService.initializeLocationService();

    // Get the initial location
    _locationSubscription =
        _locationService.getLocationUpdates((latitude, longitude) {
      setState(() {
        currentLocation = LatLng(latitude, longitude);
      });
    });
  }

  @override
  void dispose() {
    _locationSubscription.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent sightings')),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: AnimalList(onAnimalSelected: (animal) {
                setState(() {
                  animalToFind = animal;
                });
                
                
              }, isEnabled: true,),
            ),
            const SizedBox(height: 60.0),
            Text(
              'Animal to find: $animalToFind',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
            
                fetchData();
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 212, 208, 208),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Click to find',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) => _mapController = controller,
                markers: <Marker>{
                  if (currentLocation != null)
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: currentLocation!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                      infoWindow: const InfoWindow(
                        title: 'Your Location',
                        snippet: 'Current Location',
                      ),
                    ),
                  ...matchingAnimals.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> animal = entry.value;

                    return Marker(
                      markerId: MarkerId('${animal['spotId']}_$index'),
                      position: LatLng(
                        animal['locationSpotted']['latitude'],
                        animal['locationSpotted']['longitude'],
                      ),
                      infoWindow: InfoWindow(
                        title: animal['spottedAnimal'],
                        snippet: animal['dateSpotted'],
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(animal['spottedAnimal']),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      '${animal['imageURL']}',
                                      height: 400,
                                      width: 400,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        'Date Spotted: ${animal['dateSpotted']}'),
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
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }),
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    if (animalToFind.isNotEmpty) {
      try {
        // Fetch data from Firestore based on the selected animal
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collectionGroup('save_my_spot')
                .where('spottedAnimal', isEqualTo: animalToFind)
                .get();

        // Update the state with matching animals
        setState(() {
          matchingAnimals =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        });

        // Focus the camera on the markers
        _zoomToFitMarkers();
      } catch (e) {
        
        print('Error fetching data: $e');
      }
    }
  }

  GoogleMapController? _mapController;

  void _zoomToFitMarkers() {
    if (_mapController != null && matchingAnimals.isNotEmpty) {
      LatLngBounds bounds = _getBounds(matchingAnimals);
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 150));
    }
  }

  LatLngBounds _getBounds(List<Map<String, dynamic>> markers) {
    double minLat = markers.first['locationSpotted']['latitude'];
    double maxLat = markers.first['locationSpotted']['latitude'];
    double minLng = markers.first['locationSpotted']['longitude'];
    double maxLng = markers.first['locationSpotted']['longitude'];

    for (var marker in markers) {
      double lat = marker['locationSpotted']['latitude'];
      double lng = marker['locationSpotted']['longitude'];

      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
