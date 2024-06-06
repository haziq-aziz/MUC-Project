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

  Future<void> _deleteBooking(int bookId) async {
    // Show a confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this booking?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if user confirms deletion
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if user cancels deletion
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    // If user confirms deletion, proceed to delete the booking
    if (confirmDelete == true) {
      try {
        await DatabaseService().deleteBooking(bookId);
        setState(() {
          // Remove the deleted booking from the bookingList
          bookingList.removeWhere((booking) => booking.bookId == bookId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete booking')),
        );
      }
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

  void _showDetailDialog(MenuBook booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Detail'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow('Booking ID:', booking.bookId.toString()),
                _buildDetailRow('User ID:', booking.userId.toString()),
                _buildDetailRow(
                    'Booking Date:', DateFormat.yMd().format(booking.bookDate)),
                _buildDetailRow(
                    'Booking Time:', DateFormat.Hm().format(booking.bookTime)),
                _buildDetailRow(
                    'Event Date:', DateFormat.yMd().format(booking.eventDate)),
                _buildDetailRow(
                    'Event Time:', DateFormat.Hm().format(booking.eventTime)),
                _buildDetailRow('Menu Package:', booking.menuPackage ?? ''),
                _buildDetailRow(
                    'Total Guests:', booking.numGuest.toString()),
                _buildDetailRow(
                    'Package Price:', 'RM${booking.packagePrice} '), // Example: Assuming packagePrice is in RM
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingEdit(booking: booking)),
                );
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteBooking(booking.bookId);
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
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
          String formattedEventDate = DateFormat('dd-MM-yyyy').format(booking.eventDate);
          String formattedEventTime = DateFormat('HH:mm ').format(booking.eventTime);
          String formattedBookDate = DateFormat('dd-MM-yyyy').format(booking.bookDate);
          String formattedBookTime = DateFormat('HH:mm').format(booking.bookTime);

          return Card(
            child: ListTile(
              leading: Column(
                children: [
                  Text('Book ID'), // Display "Book ID" above the CircleAvatar
                  CircleAvatar(
                    child: Text('${booking.bookId}'), // Keep the existing child
                  ),
                ], // Assuming bookId is the unique identifier for bookings
              ),
              title: Text(booking.menuPackage ?? ''), // Accessing the menuPackage property of the booking
              subtitle: Text(
                'User ID: ${booking.userId} \nEvent Date: $formattedEventDate \nEvent Time: $formattedEventTime', // Concatenating userId, formatted eventDate, and eventTime
              ),
              onTap: () {
                _showDetailDialog(booking);
              },
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
                      // Call _deleteBooking method when delete button is pressed
                      _deleteBooking(booking.bookId);
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
