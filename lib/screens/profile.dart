import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const LatLng _nairobiNationalPark = LatLng(-1.399308, 36.828523);
  static const LatLng _elephantOrphanage = LatLng(-1.448368, 36.719982);
  static const LatLng _karuraForest = LatLng(-1.245670, 36.793132);
  static const LatLng _maasaiMara = LatLng(-1.411810, 35.237220);

  final List _savedSpots = [_nairobiNationalPark, _karuraForest, _maasaiMara];

  late int total;

  @override
  Widget build(BuildContext context) {
    total = _savedSpots.length;
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 60.0),
        Text('You have $total saved spots!'),
        const SizedBox(height: 60.0),
        Center(
          child: SizedBox(
            height: 400,
            width: 400,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _nairobiNationalPark,
                zoom: 13,
              ),
              markers: {
                const Marker(
                  markerId: MarkerId('nairobi_national_park'),
                  position: _elephantOrphanage,
                  infoWindow: InfoWindow(
                    title: 'Nairobi National Park',
                    snippet: 'The best national park in the world!',
                  ),
                ),
                const Marker(
                  markerId: MarkerId('karura_forest'),
                  position: _karuraForest,
                  infoWindow: InfoWindow(
                    title: 'Karura Forest',
                    snippet: 'The best forest in the world!',
                  ),
                ),
                const Marker(
                  markerId: MarkerId('maasai_mara'),
                  position: _maasaiMara,
                  infoWindow: InfoWindow(
                    title: 'Maasai Mara',
                    snippet: 'The best game reserve in the world!',
                  ),
                ),
              },
            ),
          ),
        ),
        const SizedBox(height: 60.0),
        Container(
          height: 70,
          width: 300,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 212, 208, 208),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Center(
            child: Text('Update my spots',
                style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ],
    ));
  }
}
