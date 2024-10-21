import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpo_cabs/booking.dart';
import 'package:qpo_cabs/bookingcontroler.dart';
import 'package:qpo_cabs/confirm.dart';
import 'package:qpo_cabs/conformcontroler.dart';
import 'package:qpo_cabs/home.dart';
import 'package:qpo_cabs/homecontroler.dart';
import 'package:qpo_cabs/locationcontroler.dart';
import 'package:qpo_cabs/locationride.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cab Booking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(HomeController());
          }),
        ),
        GetPage(
          name: '/location',
          page: () => LocationScreen(),
          binding: BindingsBuilder(() {
            Get.put(LocationController());
          }),
        ),
        GetPage(
          name: '/booking',
          page: () => BookingScreen(),
          binding: BindingsBuilder(() {
            Get.put(BookingController());
          }),
        ),
        GetPage(
          name: '/confirmation',
          page: () => ConfirmationScreen(),
          binding: BindingsBuilder(() {
            Get.put(ConfirmationController());
          }),
        ),
      ],
    );
  }
}