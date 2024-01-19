import 'package:ayiolo_safari_advisor/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key});

  @override
  MapsWidgetState createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {
  static const LatLng _nairobiNationalPark = LatLng(-1.397, 36.824);

  LatLng? _currentLocation;

  final LocationService _locationController = LocationService();

  @override
  void initState() {
    super.initState();
    _locationController.getLocationUpdates((latitude, longitude) {
      setState(() {
        _currentLocation = LatLng(latitude, longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              width: 400,
              child: _currentLocation == null
                  ? const Text('Loading...')
                  : GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: _nairobiNationalPark,
                        zoom: 13,
                      ),
                      markers: {
                        const Marker(
                          markerId: MarkerId('nairobiNationalPark'),
                          position: _nairobiNationalPark,
                          infoWindow: InfoWindow(
                            title: 'Nairobi National Park',
                            snippet: 'The only national park in a capital city',
                          ),
                        ),
                        Marker(
                          markerId: const MarkerId('karuraForest'),
                          position: _currentLocation!,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueMagenta),
                          infoWindow: const InfoWindow(
                            title: 'Karura Forest',
                            snippet: 'A forest in the city',
                          ),
                        ),
                      },
                    ),
            ),
            const Text(
              'Your current location is:',
              style: TextStyle(fontSize: 15.0),
            ),
            Text(
              'Latitude: ${_currentLocation?.latitude}, Longitude: ${_currentLocation?.longitude}',
              style: const TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
