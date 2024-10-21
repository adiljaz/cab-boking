import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpo_cabs/conformcontroler.dart';

class ConfirmationScreen extends GetView<ConfirmationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ride Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ride Confirmed!', style: Theme.of(context).textTheme. bodyMedium),
                    SizedBox(height: 16),
                    Text('Pickup: ${controller.pickupAddress}'),
                    Text('Dropoff: ${controller.dropoffAddress}'),
                    SizedBox(height: 8),
                    Text('Fare: \$${controller.fare.toStringAsFixed(2)}'),
                    SizedBox(height: 16),
                    Text('Driver Details:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Name: ${controller.driverName}'),
                    Text('Rating: ${controller.driverRating}'),
                    SizedBox(height: 16),
                    Obx(() => Text('ETA: ${controller.eta.value} minutes')),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.cancelRide(),
              child: Text('Cancel Ride'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}