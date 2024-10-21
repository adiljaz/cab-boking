import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:qpo_cabs/locationcontroler.dart';

class LocationScreen extends GetView<LocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Locations')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Obx(() => FlutterMap(
              options: MapOptions(
                initialCenter: controller.mapCenter.value,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.pickupLocation.value,
                      child: Icon(Icons.location_on, color: Colors.green, size: 40),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.dropoffLocation.value,
                      child: Icon(Icons.location_off, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            )),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: controller.pickupController,
                    decoration: InputDecoration(
                      labelText: 'Pickup Location',
                      prefixIcon: Icon(Icons.location_on, color: Colors.green),
                    ),
                    onChanged: (value) => controller.updatePickupLocation(value),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: controller.dropoffController,
                    decoration: InputDecoration(
                      labelText: 'Drop-off Location',
                      prefixIcon: Icon(Icons.location_off, color: Colors.red),
                    ),
                    onChanged: (value) => controller.updateDropoffLocation(value),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.confirmLocations(),
                    child: Text('Confirm Locations'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}