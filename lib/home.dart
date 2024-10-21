import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:qpo_cabs/homecontroler.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => FlutterMap(
            options: MapOptions(
              initialCenter: controller.currentLocation.value,
              initialZoom: 15.0,
              onTap: (tapPosition, point) => controller.updatePickupLocation(point),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  if (controller.currentLocation.value != LatLng(0, 0))
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.currentLocation.value,
                      child: Icon(Icons.my_location, color: Colors.blue, size: 30),
                    ),
                  if (controller.pickupLocation.value != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.pickupLocation.value!,
                      child: Icon(Icons.location_on, color: Colors.green, size: 30),
                    ),
                  if (controller.dropoffLocation.value != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.dropoffLocation.value!,
                      child: Icon(Icons.location_off, color: Colors.red, size: 30),
                    ),
                ],
              ),
            ],
          )),
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Card(
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
                      onTap: () => _showLocationPicker(context, true),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: controller.dropoffController,
                      decoration: InputDecoration(
                        labelText: 'Drop-off Location',
                        prefixIcon: Icon(Icons.location_off, color: Colors.red),
                      ),
                      onTap: () => _showLocationPicker(context, false),
                    ),
                    SizedBox(height: 16),
                    Obx(() => DropdownButton<String>(
                      value: controller.selectedRideType.value,
                      items: ['Economy', 'Premium', 'Luxury'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) => controller.updateRideType(value!),
                    )),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Get.toNamed('/location', arguments: {
                        'pickup': controller.pickupLocation.value,
                        'dropoff': controller.dropoffLocation.value,
                      }),
                      child: Text('Continue to Booking'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getCurrentLocation(),
        child: Icon(Icons.my_location),
      ),
    );
  }

  void _showLocationPicker(BuildContext context, bool isPickup) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search location',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => controller.searchLocation(value),
                ),
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final place = controller.searchResults[index];
                    return ListTile(
                      title: Text(place.name),
                      subtitle: Text(place.address),
                      onTap: () {
                        if (isPickup) {
                          controller.updatePickupLocationFromPlace(place);
                        } else {
                          controller.updateDropoffLocationFromPlace(place);
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}