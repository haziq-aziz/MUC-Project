import 'package:flutter/material.dart';
import 'package:restaurantbooking/views/profile.dart';

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
      home: Profile(),
    );
  }
}
