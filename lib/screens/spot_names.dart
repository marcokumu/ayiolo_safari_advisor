import 'package:ayiolo_safari_advisor/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key});

  @override
  MapsWidgetState createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {
  static const LatLng _nairobiNationalPark = LatLng(-1.397, 36.824);
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;

  final LocationService _locationController = LocationService();

  @override
  void initState() {
    super.initState();

    _locationController.getLocationUpdates((latitude, longitude) {
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(latitude, longitude);
        });
      }
    });

    fetchDataWithSpotName();
  }

  LatLng calculateCenter(List<LatLng> coordinates) {
    if (coordinates.isEmpty) {
      return _nairobiNationalPark;
    }

    double sumLatitude = 0.0;
    double sumLongitude = 0.0;

    for (LatLng coordinate in coordinates) {
      sumLatitude += coordinate.latitude;
      sumLongitude += coordinate.longitude;
    }

    double centerLatitude = sumLatitude / coordinates.length;
    double centerLongitude = sumLongitude / coordinates.length;

    return LatLng(centerLatitude, centerLongitude);
  }

  
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    
    Future.delayed(const Duration(seconds: 1), () {
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(
        _currentLocation ?? _nairobiNationalPark, 
        13, 

      ));
    });
  }

  Future<void> fetchDataWithSpotName() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collectionGroup('save_my_spot')
              .where('spotName', isNotEqualTo: '')
              .get();

      List<LatLng> coordinates =
          querySnapshot.docs.map((QueryDocumentSnapshot document) {
        Map<String, dynamic> locationData = document['locationSpotted'];
        double latitude = locationData['latitude'];
        double longitude = locationData['longitude'];
        String spotName = document['spotName'];
        String dateSpotted = document['dateSpotted'];
        String imageURL = document['imageURL'];

        // Create markers based on fetched coordinates
        Marker marker = Marker(
          markerId: MarkerId('$latitude,$longitude'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: spotName,
            snippet: 'Spotted on: $dateSpotted',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(spotName),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          imageURL,
                          height: 400,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text('Date Spotted: $dateSpotted'),
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

        _markers.add(marker);

        return LatLng(latitude, longitude);
      }).toList();

      // Calculate the center point of the fetched coordinates
      LatLng center = calculateCenter(coordinates);

      // Update the camera position to focus on the center
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(
        center,
        13, 
      ));

      print('Fetched Data: $_markers');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            const Text(
              'Gates, Picnic Sites, and Viewpoints',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              height: 600,
              child: _currentLocation == null
                  ? const CircularProgressIndicator()
                  : GoogleMap(
                      onMapCreated: _onMapCreated, 
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 0),
                        zoom: 1,
                      ),
                      markers: _markers,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
