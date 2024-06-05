import 'package:flutter/material.dart';
import 'package:restaurantbooking/Admin/dashboard.dart';
import 'package:restaurantbooking/Admin/user_list.dart';
import 'package:restaurantbooking/JsonModels/booking.dart';
import 'package:restaurantbooking/services/database_service.dart';
import 'package:restaurantbooking/Admin/booking_edit.dart';
import 'package:restaurantbooking/views/landingpage.dart';
import 'package:intl/intl.dart'; // Ensure you import the intl package

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  List<MenuBook> bookingList = []; // Initialize an empty list of bookings

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserList()),
        );
        break;
      case 2:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBookings(); // Call the method to fetch bookings data from the database when the widget initializes
  }

  Future<void> _fetchBookings() async {
    try {
      List<MenuBook> bookings = await DatabaseService()
          .getAllMenuBookings(); // Fetch bookings data from the database
      setState(() {
        bookingList = bookings; // Update the bookingList with the fetched data
      });
    } catch (e) {
      print('Error fetching bookings: $e');
    }
  }

  void _logout() {
    // Implement your logout logic here
    // For now, let's navigate back to the landing page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()), // Navigate to the landing page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Booking List")),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
        automaticallyImplyLeading: false, // Remove the back button
      ),
      backgroundColor: const Color(0xFF4B9EA6),
      body: ListView.builder(
        itemCount: bookingList.length,
        itemBuilder: (context, index) {
          final booking = bookingList[index];
          // Format the event date and time
          String formattedEventDate = DateFormat('yyyy-MM-dd').format(booking.eventDate);
          String formattedEventTime = DateFormat('HH:mm').format(booking.eventTime);

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${booking.bookId}'), // Assuming bookId is the unique identifier for bookings
              ),
              title: Text(booking.menuPackage ?? ''), // Accessing the menuPackage property of the booking
              subtitle: Text(
                '${booking.userId} - $formattedEventDate - $formattedEventTime', // Concatenating userId, formatted eventDate, and eventTime
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingEdit(booking: booking)),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete functionality
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4B9EA6),
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
