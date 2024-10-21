import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpo_cabs/bookingcontroler.dart';


class BookingScreen extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Booking')),
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
                    Text('Ride Details', style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 8),
                    Text('Pickup: ${controller.pickupAddress}'),
                    Text('Dropoff: ${controller.dropoffAddress}'),
                    SizedBox(height: 16),
                    Obx(() => Text(
                      'Estimated Fare: \$${controller.estimatedFare.value.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Drivers', style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 8),
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.availableDrivers.length,
                      itemBuilder: (context, index) {
                        final driver = controller.availableDrivers[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text(driver.name[0])),
                          title: Text(driver.name),
                          subtitle: Text('Rating: ${driver.rating}'),
                        );
                      },
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.confirmRide(),
              child: Text('Confirm Ride'),
            ),
          ],
        ),
      ),
    );
  }
}