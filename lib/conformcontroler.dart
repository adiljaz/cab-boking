import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class ConfirmationController extends GetxController {
  late String pickupAddress;
  late String dropoffAddress;
  late double fare;
  late String driverName;
  late double driverRating;
  
  final eta = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pickupAddress = Get.arguments['pickup'];
    dropoffAddress = Get.arguments['dropoff'];
    fare = Get.arguments['fare'];
    driverName = Get.arguments['driver'].name;
    driverRating = Get.arguments['driver'].rating;
    
    updateETA();
  }

  void updateETA() {
    eta.value = 10; // Initial ETA of 10 minutes
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (eta.value > 1) {
        eta.value--;
      } else {
        timer.cancel();
        // In a real app, you would trigger an arrival notification here
      }
    });
  }

  void cancelRide() {
    Get.dialog(
      AlertDialog(
        title: Text('Cancel Ride'),
        content: Text('Are you sure you want to cancel this ride?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              // Handle ride cancellation
              Get.offAllNamed('/'); // Return to home screen
            },
          ),
        ],
      ),
    );
  }
}