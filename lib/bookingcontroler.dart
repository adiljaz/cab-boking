import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class Driver {
  final String name;
  final double rating;

  Driver(this.name, this.rating);
}

class BookingController extends GetxController {
  late LatLng pickupLocation;
  late LatLng dropoffLocation;

  final estimatedFare = 0.0.obs;
  final availableDrivers = <Driver>[].obs;

  late String pickupAddress;
  late String dropoffAddress;

  @override
  void onInit() {
    super.onInit();
    pickupLocation = Get.arguments['pickup'];
    dropoffLocation = Get.arguments['dropoff'];
    calculateEstimatedFare();
    fetchAvailableDrivers();
    // In a real app, you would use a geocoding service to get readable addresses
    pickupAddress = '${pickupLocation.latitude}, ${pickupLocation.longitude}';
    dropoffAddress = '${dropoffLocation.latitude}, ${dropoffLocation.longitude}';
  }

  void calculateEstimatedFare() {
    // In a real app, you would use a more complex algorithm considering distance, time, and other factors
    final distance = const Distance().as(LengthUnit.Kilometer, pickupLocation, dropoffLocation);
    estimatedFare.value = distance * 2.5; // $2.50 per km
  }

  void fetchAvailableDrivers() {
    // In a real app, you would fetch this data from a backend service
    availableDrivers.addAll([
      Driver('John Doe', 4.8),
      Driver('Jane Smith', 4.9),
      Driver('Bob Johnson', 4.7),
    ]);
  }

  void confirmRide() {
    // In a real app, you would send the booking details to a backend service
    Get.toNamed('/confirmation', arguments: {
      'pickup': pickupAddress,
      'dropoff': dropoffAddress,
      'fare': estimatedFare.value,
      'driver': availableDrivers[0], // Assign the first available driver for this example
    });
  }
}