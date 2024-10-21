import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final currentLocation = LatLng(0, 0).obs;
  final pickupLocation = Rx<LatLng?>(null);
  final dropoffLocation = Rx<LatLng?>(null);
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  final selectedRideType = 'Economy'.obs;
  final searchResults = <Place>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      currentLocation.value = LatLng(position.latitude, position.longitude);
      updatePickupLocation(currentLocation.value);
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void updatePickupLocation(LatLng location) async {
    pickupLocation.value = location;
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      pickupController.text = '${placemarks.first.name}, ${placemarks.first.locality}';
    }
  }

  void updateDropoffLocation(LatLng location) async {
    dropoffLocation.value = location;
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      dropoffController.text = '${placemarks.first.name}, ${placemarks.first.locality}';
    }
  }

  void updateRideType(String type) {
    selectedRideType.value = type;
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    try {
      List<Location> locations = await locationFromAddress(query);
      searchResults.value = await Future.wait(
        locations.map((location) async {
          List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
          return Place(
            name: placemarks.first.name ?? '',
            address: '${placemarks.first.locality}, ${placemarks.first.country}',
            latLng: LatLng(location.latitude, location.longitude),
          );
        }),
      );
    } catch (e) {
      print('Error searching location: $e');
    }
  }

  void updatePickupLocationFromPlace(Place place) {
    updatePickupLocation(place.latLng);
  }

  void updateDropoffLocationFromPlace(Place place) {
    updateDropoffLocation(place.latLng);
  }
}

class Place {
  final String name;
  final String address;
  final LatLng latLng;

  Place({required this.name, required this.address, required this.latLng});
}