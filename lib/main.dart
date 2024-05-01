import 'package:flutter/material.dart';
import 'landingpage.dart';

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
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: const LandingPage(),
    );
  }
}
