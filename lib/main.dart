import 'package:flutter/material.dart';
import 'package:restaurantbooking/views/landingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Insert an admin account for testing
  //await dbService.insertAdmin('admin', 'admin');

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
