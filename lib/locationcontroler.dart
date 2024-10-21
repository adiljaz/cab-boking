import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationController extends GetxController {
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  
  final pickupLocation = LatLng(51.5, -0.09).obs;
  final dropoffLocation = LatLng(51.51, -0.1).obs;
  final mapCenter = LatLng(51.505, -0.095).obs;

  @override
  void onInit() {
    super.onInit();
    pickupLocation.value = Get.arguments['pickup'] ?? pickupLocation.value;
    dropoffLocation.value = Get.arguments['dropoff'] ?? dropoffLocation.value;
    updateMapCenter();
    updateTextFields();
  }

  @override
  void onClose() {
    pickupController.dispose();
    dropoffController.dispose();
    super.onClose();
  }

  void updatePickupLocation(String address) {
    // In a real app, use a geocoding service to convert address to coordinates
    pickupLocation.value = LatLng(51.49, -0.08);
    updateMapCenter();
  }

  void updateDropoffLocation(String address) {
    // In a real app, use a geocoding service to convert address to coordinates
    dropoffLocation.value = LatLng(51.52, -0.11);
    updateMapCenter();
  }

  void updateMapCenter() {
    mapCenter.value = LatLng(
      (pickupLocation.value.latitude + dropoffLocation.value.latitude) / 2,
      (pickupLocation.value.longitude + dropoffLocation.value.longitude) / 2,
    );
  }

  void updateTextFields() {
    pickupController.text = '${pickupLocation.value.latitude}, ${pickupLocation.value.longitude}';
    dropoffController.text = '${dropoffLocation.value.latitude}, ${dropoffLocation.value.longitude}';
  }

  void confirmLocations() {
    Get.toNamed('/booking', arguments: {
      'pickup': pickupLocation.value,
      'dropoff': dropoffLocation.value,
    });
  }
}