import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurantbooking/JsonModels/booking.dart';
import 'package:restaurantbooking/views/user_booking_edit.dart';
import 'package:restaurantbooking/views/user_view_bookings.dart';
import '../services/database_service.dart';

class UserBookingList extends StatefulWidget {
  final int userId;

  const UserBookingList({Key? key, required this.userId}) : super(key: key);

  @override
  _UserBookingListState createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  List<MenuBook> bookingList = []; // Initialize an empty list of bookings

  @override
  void initState() {
    super.initState();
    _fetchUserBookings(); // Call the method to fetch user's bookings data from the database when the widget initializes
  }

  Future<void> _fetchUserBookings() async {
    try {
      List<MenuBook> bookings = await DatabaseService().getUserMenuBookings(widget.userId); // Fetch user's bookings data from the database
      setState(() {
        bookingList = bookings; // Update the bookingList with the fetched data
      });
    } catch (e) {
      print('Error fetching user bookings: $e');
    }
  }

  Widget _buildEditButton(MenuBook booking) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserBookingEdit(booking: booking)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Bookings')),
      body: ListView.builder(
        itemCount: bookingList.length,
        itemBuilder: (context, index) {
          final booking = bookingList[index];
          String formattedEventDate = DateFormat('dd-MM-yyyy').format(booking.eventDate);
          String formattedEventTime = DateFormat('HH:mm').format(booking.eventTime);

          return Card(
            child: ListTile(
              title: Text(booking.menuPackage),
              subtitle: Text('Event Date: $formattedEventDate\nEvent Time: $formattedEventTime'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildEditButton(booking),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteBooking(booking.bookId);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteBooking(int bookId) async {
    try {
      await DatabaseService().deleteBooking(bookId);
      setState(() {
        bookingList.removeWhere((booking) => booking.bookId == bookId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete booking')),
      );
    }
  }
}