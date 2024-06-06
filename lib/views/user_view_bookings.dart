import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantbooking/services/database_service.dart';
import 'package:restaurantbooking/JsonModels/booking.dart';
import 'package:restaurantbooking/views/landingpage.dart';
import 'package:intl/intl.dart'; // Ensure you import the intl package

class UserBookingList extends StatefulWidget {
  final int userId; // Add a parameter to pass the logged-in user's ID

  const UserBookingList({super.key, required this.userId});

  @override
  _UserBookingListState createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  List<MenuBook> bookingList = []; // Initialize an empty list of bookings

  @override
  void initState() {
    super.initState();
    _fetchBookings(); // Call the method to fetch bookings data from the database when the widget initializes
  }

  Future<void> _fetchBookings() async {
    try {
      List<MenuBook> bookings = await DatabaseService()
          .getUserMenuBookings(widget.userId); // Fetch bookings data for the specific user
      setState(() {
        bookingList = bookings; // Update the bookingList with the fetched data
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching bookings: $e');
      }
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

  void _showDetailDialog(MenuBook booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Detail'),
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
                _buildDetailRow('Menu Package:', booking.menuPackage),
                _buildDetailRow(
                    'Total Guests:', booking.numGuest.toString()),
                _buildDetailRow(
                    'Package Price:', 'RM${booking.packagePrice} '), // Example: Assuming packagePrice is in RM
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
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
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
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
        title: const Center(child: Text("Your Bookings")),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
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
          DateFormat('dd-MM-yyyy').format(booking.bookDate);
          DateFormat('HH:mm').format(booking.bookTime);

          return Card(
            child: ListTile(
              leading: Column(
                children: [
                  const Text('Book ID'), // Display "Book ID" above the CircleAvatar
                  CircleAvatar(
                    child: Text('${booking.bookId}'), // Keep the existing child
                  ),
                ], // Assuming bookId is the unique identifier for bookings
              ),
              title: Text(booking.menuPackage), // Accessing the menuPackage property of the booking
              subtitle: Text(
                'Event Date: $formattedEventDate \nEvent Time: $formattedEventTime', // Concatenating formatted eventDate and eventTime
              ),
              onTap: () {
                _showDetailDialog(booking);
              },
            ),
          );
        },
      ),
    );
  }
}
