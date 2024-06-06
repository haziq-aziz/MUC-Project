// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:restaurantbooking/views/landingpage.dart';
import 'package:restaurantbooking/Admin/user_list.dart'; // Import the UserList screen
import 'package:restaurantbooking/Admin/booking_list.dart'; // Import the BookingList screen

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index
    switch (index) {
      case 0:
        // Navigate to Home screen (not implemented yet)
        break;
      case 1:
        // Navigate to Users screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserList()), // Navigate to the UserList screen
        );
        break;
      case 2:
        // Navigate to Bookings screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingList()), // Navigate to the BookingList screen
        );
        break;
    }
  }

  void _logout() {
    // Implement your logout logic here
    // For now, let's navigate back to the landing page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LandingPage()), // Navigate to the landing page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Center(child: Text("Admin Dashboard")), // Center the text
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      backgroundColor: const Color(0xFF4B9EA6),
      body: const Center(
        child: Text("Welcome to the Admin Dashboard!"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4B9EA6), // Set the selected tab color
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
}
