import 'package:flutter/material.dart';
import 'package:restaurantbooking/Authentication/login.dart';
import 'package:restaurantbooking/screens/landingpage.dart';

void main() {
  runApp(const RestaurantBooking());
}

class RestaurantBooking extends StatelessWidget {
  const RestaurantBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Booking App',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: const LandingPage(),
    );
  }
}
