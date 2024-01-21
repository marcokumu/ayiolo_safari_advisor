import 'package:location/location.dart';
import 'dart:async';

class LocationService {
  final Location _locationController = Location();

  StreamSubscription<LocationData> getLocationUpdates(
      void Function(double, double)? onLocationChanged) {
    return _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (onLocationChanged != null) {
        onLocationChanged(
            currentLocation.latitude!, currentLocation.longitude!);
      }
    });
  }

   Future<LocationData> getCurrentLocation() async {
    try {
      return await _locationController.getLocation();
    } catch (e) {
      print('Error getting current location: $e');
      return LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0});
    }
  }

  Future<void> initializeLocationService() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    print('Service Enabled: $serviceEnabled');

    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      print('Service Enabled after request: $serviceEnabled');
      if (!serviceEnabled) {
        print('Location service not enabled, cannot proceed.');
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    print('Permission Status: $permissionGranted');

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      print('Permission Status after request: $permissionGranted');
      if (permissionGranted != PermissionStatus.granted) {
        print('Permission not granted');
        return;
      }
    }
  }
}
