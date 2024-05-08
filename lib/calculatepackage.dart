import 'package:flutter/material.dart';
import 'inputdata.dart';

class CalculatePackage extends StatefulWidget {
  const CalculatePackage({required this.booking});

  final ReservationFormData booking;

  @override
  CalculatePackageState createState() => CalculatePackageState();
}

class CalculatePackageState extends State<CalculatePackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Name: ${widget.booking.email}'), // Access booking using widget.booking
          ],
        ),
      ),
    );
  }
}
